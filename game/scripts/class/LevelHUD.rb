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