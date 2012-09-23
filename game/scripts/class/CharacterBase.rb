class CharacterBase < Character
	
	attr_reader :row
	
	def initialize(ops = {})
		super(ops)
		@row = 1 if @row == nil
		@rows = []
		size = @bitmaps.size / 4
		@rows = [@bitmaps[0...size], @bitmaps[size...(size*2)], @bitmaps[(size*2)...(size*3)], @bitmaps[(size*3)...(size*4)]]
		@bitmaps = @rows[@row]
		@bitmap = @bitmaps[0]
	end
	
	def row=(i)
		index = @bitmaps.index(@bitmap)
		@bitmaps = @rows[i]
		@row = i
		@bitmap = @bitmaps[index]
	end
	
	def reset
		@bitmap = @bitmaps[0]
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