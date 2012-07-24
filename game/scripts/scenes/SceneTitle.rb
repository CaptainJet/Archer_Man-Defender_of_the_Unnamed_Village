class SceneTitle < Scene
	
	CONTROLS = %Q{Controls:\n  Up/W: Move Up\n  Down/S: Move Down\n  A: Shoot Arrow\n  1: Heal 5 health for 50 souls\n  2: Shoot 20 arrows automatically for 20 souls\n  3: Shoot 25 randomly placed arrows for 30 souls\n  4: Slow down Enemies for 5 second for 15 souls\n  ESC: Pause the game}
	
	def initialize
		super
		@image = Sprite.new(bitmap: Bitmap.new("Title"), opacity: 0, z: 1)
		@bg = Sprite.new(bitmap: Bitmap.new("", nil, true))
		col = Color::WHITE
		@font = Font.new($main_window, Gosu.default_font_name, 30)
		@controls = Image.from_text($main_window, CONTROLS, Gosu.default_font_name, 20, 16, 500, :left)
		@bg.bitmap.image = $main_window.record($main_window.width, $main_window.height) { $main_window.draw_quad(0, 0, col, 0, $main_window.height, col, $main_window.width, $main_window.height, col, $main_window.width, 0, col) }
	end
	
	def update
		super
		if @image.opacity != 255
			@image.opacity += 4.25
			if Input.trigger?(:Return)
				@image.opacity = 255
			end
		else
			if Input.trigger?(:Return) || Input.trigger?(:Enter)
				$scene = SceneLevel.new
				terminate
			end
		end
	end
	
	def terminate
		super
		@image.dispose
		@bg.dispose
		@font = nil
		@controls = nil
	end
	
	def draw
		super
		return unless @image.opacity == 255
		width = @font.text_width("Press Enter To Play")
		@font.draw("Press Enter to Play", $main_window.width / 2 - width / 2, 400, 50)
		@controls.draw(10, 200, 50, 1, 1, Color::BLACK)
	end
end