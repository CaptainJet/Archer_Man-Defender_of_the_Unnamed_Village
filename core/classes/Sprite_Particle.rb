class Sprite_Particle < Sprite
	
	attr_accessor :life_span, :x_move, :y_move, :color
	
	def initialize(life_span, x_move, y_move, color, ops = {})
		super(ops)
		@life_span = life_span
		@x_move = x_move
		@y_move = y_move
		@color = color
	end
	
	def update
		super
		@life_span -= 1
		if @life_span <= 0
			dispose
		end
		self.x += @x_move
		self.y += @y_move
		@opacity -= 255 / @life_span.to_f
	end
	
	def draw
		return if !on_screen?
		@bitmap.draw(@x, @y, @z, @mirror ? -1 : 1, 1, opac_color)
	end
	
	def opac_color
		col = @color
		@color.alpha = @opacity
		col
	end
end