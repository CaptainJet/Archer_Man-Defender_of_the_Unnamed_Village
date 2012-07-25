class SceneTitle < Scene
	
	CONTROLS = %Q{Controls:\n  Up/W: Move Up\n  Down/S: Move Down\n  A: Shoot Arrow\n  1: Heal 5 health for 50 souls\n  2: Shoot 20 arrows automatically for 20 souls\n  3: Shoot 25 randomly placed arrows for 30 souls\n  4: Slow down Enemies for 5 second for 15 souls\n  ESC: Pause}
	
	def initialize
		super
		if $song.nil?
			$song = Song.new($main_window, "game/media/audio/BG.ogg")
			$song.play(true)
		end
		@image = Sprite.new(bitmap: Bitmap.new("Title"), opacity: 0, z: 1)
		@bg = Sprite.new(bitmap: Bitmap.new("", nil, true))
		col = Color::WHITE
		@font = Font.new($main_window, Gosu.default_font_name, 30)
		@hfont = Font.new($main_window, Gosu.default_font_name, 30)
		@controls = Image.from_text($main_window, CONTROLS, Gosu.default_font_name, 16, 14, 500, :left)
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
			elsif Input.trigger?(:Space)
				$scene = SceneHighScoreNoEntry.new
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
		width = @font.text_width("Press Space To View High Scores")
		@font.draw("Press Space To View High Scores", $main_window.width / 2 - width / 2, 440, 50)
		@controls.draw(10, 210, 50, 1, 1, Color::BLACK)
	end
end

# Archer Man: Defender of the Unnamed Village
# Copyright (C) 2012 Robert Rowe
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.