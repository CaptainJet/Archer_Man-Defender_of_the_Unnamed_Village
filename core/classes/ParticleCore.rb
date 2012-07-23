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
			@sprites.push(sprite)
		} unless @disposed
		@sprites.each {|a| a.update }
		@sprites = @sprites.reject {|a| a.disposed? }
	end
	
	def dispose
		@disposed = true
	end
	
	def empty?
		@sprites.empty?
	end
end