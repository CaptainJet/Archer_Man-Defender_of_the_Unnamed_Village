class LevelHud
	
	def initialize
		@sprites = Array.new(4) { Font.new($main_window, Gosu.default_font_name, 20) }
		@score = $data[:score]
		@souls = $data[:souls]
		@slain = $data[:slain]
		@health = $data[:health]
	end
	
	def draw
		@image ||= (
		$main_window.record($main_window.width, $main_window.height) { @sprites[0].draw("Score: #{@score}", 5, 5, 50)
		@sprites[1].draw("Souls: #{@souls}", 5, 30, 50)
		@sprites[2].draw("Slain: #{@slain}", 5, 55, 50)
		@sprites[3].draw("Health: #{@health}", 940, 5, 50) })
		if [@score, @souls, @slain, @health] != [$data[:score], $data[:souls], $data[:slain], $data[:health]]
			@score = $data[:score]
			@souls = $data[:souls]
			@slain = $data[:slain]
			@health = $data[:health]
			@image = (
			$main_window.record($main_window.width, $main_window.height) { @sprites[0].draw("Score: #{@score}", 5, 5, 50)
			@sprites[1].draw("Souls: #{@souls}", 5, 30, 50)
			@sprites[2].draw("Slain: #{@slain}", 5, 55, 50)
			@sprites[3].draw("Health: #{@health}", 940, 5, 50) })
		end
		@image.draw(0, 0, 50)
	end
end