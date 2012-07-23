class SceneTitle < Scene
	
	def initialize
		super
		@options = ["Play", "Options", "High Scores"]
		@image = Sprite.new(bitmap: Bitmap.new("Title"), opacity: 0, z: 1)
		@bg = Sprite.new(bitmap: Bitmap.new("", nil, true))
		col = Color::WHITE
		@font = Font.new($main_window, Gosu.default_font_name, 30)
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
	end
	
	def draw
		super
		return unless @image.opacity == 255
		width = @font.text_width("Press Enter To Play")
		@font.draw("Press Enter to Play", $main_window.width / 2 - width / 2, 400, 50)
	end
end