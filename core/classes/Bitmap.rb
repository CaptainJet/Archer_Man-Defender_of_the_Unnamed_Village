class Bitmap
	
	attr_accessor :image, :name
	
	def initialize(name, rect = nil, text = false)
		if !text
			if rect.nil?
				@image = Image.new($main_window, "./game/media/images/#{name}.png", false)
			else
				@image = Image.new($main_window, "./game/media/images/#{name}.png", false, rect.x, rect.y, rect.width, rect.height)
			end
			@name = "./game/media/images/#{name}.png"
		end
	end
	
	def draw(*args)
		@image.draw(*args) unless @image.nil?
	end
	
	def self.draw_text(text, font = default_font_name, height = 20, line_height = 4, width = $main_window.width, align = :left)
		bit = Bitmap.new("", nil, true)
		bit.image = Image.from_text($main_window, text, font, height, line_height, width, align)
		return bit
	end
	
	def width
		@image.width
	end
	
	def height
		@image.height
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