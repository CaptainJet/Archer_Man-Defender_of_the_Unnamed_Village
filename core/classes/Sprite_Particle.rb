class Sprite_Particle < Sprite
	
	attr_accessor :life_span, :x_move, :y_move, :color
	
	def initialize(life_span, x_move, y_move, color, ops = {})
		super(ops)
		@life_span = life_span
		@x_move = x_move
		@y_move = y_move
		@color = color
	end
	
	def update
		super
		@life_span -= 1
		if @life_span <= 0
			dispose
		end
		self.x += @x_move
		self.y += @y_move
		@opacity -= 255 / @life_span.to_f
	end
	
	def draw
		return if !on_screen?
		@bitmap.draw(@x, @y, @z, @mirror ? -1 : 1, 1, opac_color)
	end
	
	def opac_color
		col = @color
		@color.alpha = @opacity
		col
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