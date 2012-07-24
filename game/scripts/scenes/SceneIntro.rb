class SceneIntro < Scene
	
	def initialize
		super
		@image = Sprite.new(bitmap: Bitmap.new("Intro"), y: $main_window.height)
	end
	
	def update
		super
		if Input.trigger?(:Return)
			terminate
		else
			@image.y -= 0.5
			if @image.y == -@image.bitmap.height
				terminate
			end
		end
	end
	
	def terminate
		super
		@image.dispose
		$scene = SceneTitle.new
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