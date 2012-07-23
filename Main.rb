require 'bundler/setup'
require 'gosu'
require 'rest_client'
exit if Object.const_defined?(:Ocra)

include Gosu

Dir.chdir(File.dirname($0))

Dir["core/**/*.rb"].each {|script| require "./#{script}" }

#~ url = "http://chingu:chingu@www.gamercv.com/games/1/high_scores.json"
#~ RestClient.post(url, {"high_score" => {"name" => "BLUEH", "score" => "10010", "text" => ""}})

class Game < Gosu::Window
	
	def initialize(width, height, fullscreen)
		super(width, height, fullscreen)
		self.caption = "Jet's Contest Game"
	end
	
	def update
		Input.update
		Tasks.update
		$scene.update
		self.caption = "Jet's Contest Game (#{Gosu.fps} FPS)"
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
Dir["game/scripts/**/*.rb"].each {|a| require "./" + a }
$scene = SceneIntro.new
$main_window.show