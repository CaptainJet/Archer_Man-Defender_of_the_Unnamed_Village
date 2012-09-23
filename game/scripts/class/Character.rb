class Character < Sprite
	
	TIME = 5
	
	attr_accessor :animate, :particle_core
	
	def initialize(ops = {})
		super(ops)
		@t_width = 32 if @t_width == nil
		@t_height = 32 if @t_height == nil
		@animate = true if @animate == nil
		@bitmaps = Image.load_tiles($main_window, @bitmap.name, @t_width, @t_height, false)
		@bitmaps = @bitmaps.collect {|a| b = Bitmap.new("", nil, true); b.image = a; b}
		@bitmap = @bitmaps[0]
		@timer = 0
	end
	
	def update
		super
		@timer = [@timer + 1, TIME].min
		if @animate
			if @timer == TIME
				index = @bitmaps.index(@bitmap) + 1
				if index == @bitmaps.size
					@bitmap = @bitmaps[0]
				else
					@bitmap = @bitmaps[index]
				end
				@timer = 0
			end
		else
			@bitmap = @bitmaps[0]
		end
		if @particle_core
			@particle_core.x = self.x + @bitmap.width / 2
			@particle_core.y = self.y + @bitmap.height / 2
			if @particle_core.size == 0
				@particle_core = nil
			end
		end
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