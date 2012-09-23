begin
require 'rubygems'
rescue LoadError
end

require 'gosu'
require 'rest_client'

include Gosu

Dir.chdir(File.dirname($0))
Dir["core/**/*.rb"].sort.each {|script| 
	require "./#{script}"
}

class Game < Gosu::Window
	
	def initialize(width, height, fullscreen)
		super(width, height, fullscreen)
		self.caption = "Archer Man: Defender of the Unnamed Village"
	end
	
	def update
		Input.update
		Tasks.update
		$scene.update
	end
	
	def draw
		Graphics.update
		$scene.draw
	end
	
	def button_down(id)
		Input.add_key(id)
	end
	
	def needs_cursor?
		true
	end
	
	def rect
		@rect ||= Rect.new(0, 0, self.width, self.height)
	end
end

$main_window = Game.new(1024, 576, false)
Dir["game/scripts/**/*.rb"].sort.each {|a| require "./" + a }
$scene = SceneIntro.new
$main_window.show

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