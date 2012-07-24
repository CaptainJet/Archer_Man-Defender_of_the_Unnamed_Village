class SceneLevel < Scene
	
	CONTROLS = %Q{Controls:\n  Up/W: Move Up\n  Down/S: Move Down\n  A: Shoot Arrow\n  1: Heal 5 health for 50 souls\n  2: Shoot 20 arrows automatically for 20 souls\n  3: Shoot 25 randomly placed arrows for 30 souls\n  4: Slow down Enemies for 5 second for 15 souls\n  ESC: Pause}
	SKILL_NAMES = ["Heal", "Auto-Arrow", "Arrow Wave", "Slow Time"]
	
	PLAYER = CharacterBase.new(:visible => false, :bitmap => Bitmap.new("Player"), :x => $main_window.width - 64, :y => 0, :t_width => 64, :t_height => 64, :z => 1)
	ATTACK = CharacterBase.new(:visible => false, :bitmap => Bitmap.new("Player Bow"), :x => $main_window.width - 64, :y => 0, :t_width => 64, :t_height => 64, :z => 1)
	ENEMY = Enemy.new(:bitmap => Bitmap.new("Enemy"), :x => -64, :t_width => 64, :t_height => 64, :z => 1, :row => 3, :animate => true, :hp => 1, :level => 0)
	ENEMY_ARMOR = Enemy.new(:bitmap => Bitmap.new("Enemy Armor"), :x => -64, :t_width => 64, :t_height => 64, :z => 1, :row => 3, :animate => true, :hp => 2, :level => 1)
	ENEMY_RED = Enemy.new(:bitmap => Bitmap.new("Enemy Red"), :x => -64, :t_width => 64, :t_height => 64, :z => 1, :row => 3, :animate => true, :hp => 3, :level => 2)
	ARROW = Sprite.new({:bitmap => Bitmap.new("Arrow"), :z => 2, :x => -64})
	
	def initialize
		$data = {:slain => 0, :souls => 0, :score => 0, :health => 10}
		PLAYER.visible = true
		@player = PLAYER
		@map = Sprite.new(:bitmap => Bitmap.new("Map"), :z => 0)
		@arrows = []
		@enemies = Array.new(10) { 
			a = ENEMY.dup
			Graphics.add_sprite(a)
			a.y = rand($main_window.height - 128) 
			a 
		}
		@active_enemies = []
		@timer = 180
		@level = 1
		@part = []
		@part_timer = 0
		@dying_parts = []
		@hud = LevelHud.new
		@fonts = Array.new(1) { Font.new($main_window, Gosu.default_font_name, 20) }
		4.times { @fonts.push(Font.new($main_window, Gosu.default_font_name, 16)) }
		@paused = false
		@slowdown = 0
		@dying = false
		@controls = Image.from_text($main_window, CONTROLS, Gosu.default_font_name, 16, 14, 500, :left)
	end
	
	def update
		super
		update_pause if !@dying
		if !@paused && !@dying
			update_player
			update_specials
			update_arrows
			update_collisions
			update_enemies
			update_collisions
			update_particles
		end
		update_dying if @dying
	end
	
	def update_pause
		@paused = !@paused if Input.trigger?(:Escape)
	end
	
	def update_player
		moved = false
		if Input.press?(:Down) || Input.press?(:S) and @player != ATTACK
			@player.animate = true
			@player.y = [@player.y + 4, $main_window.height - 128].min
			moved = true
		elsif Input.press?(:Up) || Input.press?(:W) and @player != ATTACK
			@player.animate = true
			@player.y = [@player.y - 4, 0].max
			moved = true
		end
		if Input.trigger?(:A) || Input.trigger?(:Left) and @player != ATTACK
			ATTACK.x = @player.x
			ATTACK.y = @player.y
			@player.visible = false
			@player = ATTACK
			@player.visible = true
			@player.animate = true
			Tasks.new_task(45) { new_arrow }
			Tasks.new_task(55) { @player.visible = false; @player.reset; @player = PLAYER; @player.visible = true}
		end
		if @player != ATTACK && !moved
			@player.animate = false
		end
		@player.update
	end
	
	def new_arrow
		arrow = ARROW.dup
		Graphics.add_sprite(arrow)
		arrow.x = @player.x + 11
		arrow.y = @player.y + 30
		@arrows.push(arrow)
	end
	
	def new_arrow_rand
		arrow = ARROW.dup
		Graphics.add_sprite(arrow)
		arrow.x = @player.x + 11
		arrow.y = rand($main_window.height - 128) 
		@arrows.push(arrow)
	end
	
	def update_arrows
		@arrows.each {|a|
			a.x -= 6
			a.dispose if !a.on_screen?
			@arrows[@arrows.index(a)] = nil if a.disposed?
		}
		@arrows.compact!
	end
	
	def update_enemies
		@timer = [@timer - 1, 0].max
		if @timer == 0 && !@enemies.empty?
			@active_enemies.push(@enemies.pop)
			@active_enemies.sort! {|a, b| a.y <=> b.y }
			@timer = rand(90..level_timer)
		end
		@active_enemies.each {|a| 
			a.update
			a.x += enemy_speed(a)
			if a.x >= $main_window.width - 50 && !a.disposed?
				@part.push(ParticleCore.new("Orb", a.x + 30, a.y + 30, Color.rgba(159, 0, 0, 255)))
				@part_timer += 60
				a.dispose
				$data[:health] = [$data[:health] - (a.level + 1), 0].max
				player_die if $data[:health] == 0
			end
			@active_enemies[@active_enemies.index(a)] = nil if a.disposed?
		}
		@active_enemies.compact!
		next_wave if @active_enemies.empty? && @enemies.empty?
	end
	
	def update_particles
		@part.each {|a| a.update }
		@part_timer = [@part_timer - 1, 0].max
		if @part_timer % 60 == 0 && !@part.empty?
			f = @part.shift
			@dying_parts.push(f)
			f.dispose
		end
		@dying_parts.each {|a|
			a.update
			@dying_parts[@dying_parts.index(a)] = nil if a.empty?
		}
		@dying_parts.compact!
	end
	
	def update_collisions
		@arrows.each {|arrow|
			next if arrow.disposed?
			@active_enemies.each {|enemy|
				next if enemy.disposed?
				break if arrow.disposed?
				en_rect = enemy.rect
				en_rect.x -= 30
				if arrow.rect.intersects?(en_rect)
					arrow.dispose
					enemy.hp -= 1
					@part.push(ParticleCore.new("Orb", enemy.x + 30, enemy.y + 30, Color.rgba(0, 0, 129, 255)))
					@part_timer += enemy.hp <= 0 ? 60 : 10
				end
			}
		}
	end
	
	def update_specials
		if Input.trigger?("1")
			return unless $data[:souls] >= 50
			$data[:souls] -= 50
			$data[:health] = [$data[:health] + 5, 10].min
			f = ParticleCore.new("Orb", 0, 0, Color.rgba(255, 190, 0, 255))
			@player.particle_core = f
			@part.push(f)
			@part_timer += 60
		elsif Input.trigger?("2") and @player != ATTACK
			return unless $data[:souls] >= 20
			$data[:souls] -= 20
			ATTACK.x = @player.x
			ATTACK.y = @player.y
			@player.visible = false
			@player = ATTACK
			@player.visible = true
			@player.animate = true
			20.times {|i|
				Tasks.new_task(45 + i * 15) { new_arrow }
			}
			Tasks.new_task(55) { @player.visible = false; @player.reset; @player = PLAYER; @player.visible = true}
		elsif Input.trigger?("3") and @player != ATTACK
			return unless $data[:souls] >= 30
			$data[:souls] -= 30
			ATTACK.x = @player.x
			ATTACK.y = @player.y
			@player.visible = false
			@player = ATTACK
			@player.visible = true
			@player.animate = true
			25.times {|i|
				Tasks.new_task(45 + i * 15) { new_arrow_rand }
			}
			Tasks.new_task(55) { @player.visible = false; @player.reset; @player = PLAYER; @player.visible = true}
		elsif Input.trigger?("4")
			return unless $data[:souls] >= 15
			$data[:souls] -= 15
			@slowdown = 3
			Tasks.new_task(300) { @slowdown = 0 }
			f = ParticleCore.new("Orb", 0, 0, Color.rgba(255, 190, 0, 255))
			@player.particle_core = f
			@part.push(f)
			@part_timer += 60
		end
	end
	
	def reset_player
		@player.visible = false
		@player.animate = false
		@player = PLAYER
	end
	
	def level_timer
		[120 - @level, 60].max
	end
	
	def enemy_speed(enemy)
		x = 1 + (@level * 0.15)
		x = [x, 5].min
		x = 1 if enemy.level == 2
		x = [x, 2].min if enemy.level == 1
		x -= @slowdown
		[x, 1].max
	end
	
	def next_wave
		@level += 1
		@enemies = []
		@enemies = Array.new(10 + @level * 7) { 
			a = ENEMY.dup
			Graphics.add_sprite(a)
			a.y = rand($main_window.height - 128) 
			a 
		}
		(@level * 0.8).round.times {
			a = ENEMY_ARMOR.dup
			Graphics.add_sprite(a)
			a.y = rand($main_window.height - 128) 
			@enemies.insert(rand(@enemies.size), a) 
		}
		((@level - 1) / 2).times {
			a = ENEMY_RED.dup
			Graphics.add_sprite(a)
			a.y = rand($main_window.height - 128) 
			@enemies.insert(rand(@enemies.size), a) 
		}
	end
	
	def player_die
		@dying = true
		col = Color.rgba(0, 0, 0, 255)
		@bg = Sprite.new(bitmap: Bitmap.draw_text(" "), :opacity => 0, :z => 49)
		f = ParticleCore.new("Orb", @player.x, @player.y, Color.rgba(159, 0, 0, 255))
		@player.particle_core = f
		@player.particle_core.update
	end
	
	def update_dying
		update_particles
		@player.update
		@player.particle_core.update
		@bg.opacity += 2.125
		if @bg.opacity >= 255
			$scene = SceneHighScore.new
			terminate
		end
	end
	
	def draw
		super
		@hud.draw
		if @paused
			@fonts[0].draw("Paused", $main_window.width / 2 - @fonts[0].text_width("Paused") / 2, $main_window.height / 2 - 10, 50)
			@controls.draw(10, 210, 50, 1, 1, Color::BLACK)
		else
			[50, 20, 30, 15].each_with_index {|a, i|
				col = $data[:souls] >= a ? Color::WHITE : Color::BLACK
				@fonts[i + 1].draw("#{i + 1}: #{SKILL_NAMES[i]}", 10, 450 + i * 18, 50, 1, 1, col)
			}
		end
		if @dying
			col = Color.rgba(0, 0, 0, @bg.opacity)
			$main_window.draw_quad(0, 0, col, 0, $main_window.height, col, $main_window.width, $main_window.height, col, $main_window.width, 0, col)
		end
	end
	
	def terminate
		PLAYER.dispose
		ATTACK.dispose
		ENEMY.dispose
		ENEMY_RED.dispose
		ENEMY_ARMOR.dispose
		ARROW.dispose
		@map.dispose
		@arrows.each {|a| a.dispose}
		@enemies.each {|a| a.dispose }
		@active_enemies.each {|a| a.dispose }
		@part.each {|a| a.dispose }
		(@part + @dying_parts).each {|a| 50.times { a.update } }
		@player.particle_core.dispose
		@player.particle_core.update while !@player.particle_core.empty?
	end
end