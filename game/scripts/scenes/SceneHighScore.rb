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
		RestClient.post(URL, {"high_score" => {"name" => $main_window.text_input.text, "score" => "#{$data[:score]}", "text" => "Killed: #{$data[:slain]}"}})
	end
	
	def get_high_scores
		highs = (RestClient.get(URL, {:accept => :json}) rescue return false)
		erks = []
		highs.gsub(/\[|\]/i, "").split("}").each {|a|
			name = a.match(/\"name\"\:\"(.+)\",/i)[1]
			position = a.match(/\"position\"\:(\d+),/i)[1].to_i
			score = a.match(/\"score\"\:(\d+),/i)[1].to_i
			text = a.match(/\"text\"\:\"(.+)\"/i)[1]
			erks.push([position, name, score, text])
		}
		erks.sort {|a, b| b[0] <=> a[0] }
	end
	
	def draw
		super
		@hud.draw
		@title.draw("High Scores:", 25, 125, 50)
		@fonts.each_with_index {|a, i|
			args = @high_scores[i]
			a.draw("#{args[0]}.) #{args[1]} - #{args[2]} (#{args[3]})", 50, 150 + i * 16, 50)
		}
		@submit.draw("Enter your name:", 500, 125, 50)
		text = $main_window.text_input.text.dup
		text.concat("|") if text.length < 6
		@current_input.draw(text, 525, 250, 50)
	end
end