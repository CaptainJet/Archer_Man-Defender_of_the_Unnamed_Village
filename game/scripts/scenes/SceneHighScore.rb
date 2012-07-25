class SceneHighScore < Scene
	
	URL = "http://captain:jeticus@gamercv.com/games/33/high_scores"
	
	def initialize
		if !(@high_scores = get_high_scores)
			$scene = SceneTitle.new
			return
		end
		@hud = LevelHud.new
		@title = Font.new($main_window, Gosu.default_font_name, 20)
		@fonts = Array.new(10) { Font.new($main_window, Gosu.default_font_name, 14) }
		@submit = Font.new($main_window, Gosu.default_font_name, 20)
		@current_input = Font.new($main_window, Gosu.default_font_name, 24)
		$main_window.text_input = TextInput.new
		@bg = Sprite.new(:bitmap => Bitmap.new("Map BW"))
	end
	
	def update
		super
		if Input.trigger?(:Return) || Input.trigger?(:Enter)
			post_high_score
			$main_window.text_input = nil
			$scene = SceneTitle.new
		end
	end
	
	def post_high_score
		begin
			RestClient.post(URL, {"high_score" => {"name" => $main_window.text_input.text, "score" => "#{$data[:score]}", "text" => "Killed: #{$data[:slain]}"}})
		rescue
		end
	end
	
	def get_high_scores
		retried = false
		begin
			highs = RestClient.get(URL, {:accept => :json})
			erks = []
			highs.gsub(/\[|\]/i, "").split("}").each {|a|
				name = a.match(/\"name\"\:\"(.+)\",/i)[1]
				position = a.match(/\"position\"\:(\d+),/i)[1].to_i
				score = a.match(/\"score\"\:(\d+),/i)[1].to_i
				text = a.match(/\"text\"\:\"(.+)\"/i)[1]
				erks.push([position, name, score, text])
			}
			erks.sort {|a, b| b[2] <=> a[2] }
		rescue
			(retried = true; retry) if !retried
			return false
		end
	end

	def draw
		super
		@hud.draw
		@title.draw("High Scores:", 25, 125, 55)
		@fonts.each_with_index {|a, i|
			args = @high_scores[i]
			a.draw("#{i + 1}.) #{args[1]} - #{args[2]} (#{args[3]})", 50, 155 + i * 16, 50)
		}
		@submit.draw("Enter your name:", 500, 125, 50)
		text = $main_window.text_input.text.dup
		text.concat("|")
		@current_input.draw(text, 525, 250, 50)
	end
	
	def terminate
		super
		@bg.dispose
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