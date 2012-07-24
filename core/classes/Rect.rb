class Rect
	
	attr_accessor :x, :y, :width, :height
	
	def initialize(x, y, width, height)
		@x = x
		@y = y
		@width = width
		@height = height
	end
	
	def intersects?(rect)
		return ((((rect.x < (self.x + self.width)) && (self.x < (rect.x + rect.width))) && (rect.y < (self.y + self.height))) && (self.y < (rect.y + rect.height)))
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