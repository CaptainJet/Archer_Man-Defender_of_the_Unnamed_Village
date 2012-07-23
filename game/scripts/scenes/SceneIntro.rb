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