class ParticleCore
	
	@@core_colors = [Color::RED, Color::BLUE, Color::GREEN, Color::FUCHSIA, Color::CYAN, Color::YELLOW]
	
	attr_accessor :x, :y
	
	def initialize(image, x, y, color = @@core_colors)
		@sprites = []
		@image = Bitmap.new(image)
		@x = x
		@y = y
		@color = color
	end
	
	def update
		col = @color.is_a?(Array) ? @color.sample : @color
		3.times {
			sprite = Sprite_Particle.new(rand(15..80), rand(-3..3), rand(-3..3), col, :bitmap => @image, :z => 3)
			sprite.x = @x
			sprite.y = @y
			@sprites << sprite
		} unless @disposed
		@sprites.cycle(1) {|a| a.update }
		@sprites = @sprites.reject {|a| a.disposed? }
	end
	
	def dispose
		@disposed = true
	end
	
	def empty?
		@sprites.size == 0
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