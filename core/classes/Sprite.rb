class Sprite
	
	attr_accessor :x, :y, :z, :bitmap, :opacity, :visible, :mirror
	
	def initialize(ops = {})
		ops = {x: 0, y: 0, z: 0, bitmap: nil, opacity: 255, visible: true, mirror: false}.merge(ops)
		ops.each {|a, b|
			instance_variable_set(a.to_s.prepend("@").to_sym, b)
		}
		Graphics.add_sprite(self)
		@disposed = false
	end
	
	def update
	end
	
	def draw
		return if !on_screen?
		@bitmap.draw(@x, @y, @z, @mirror ? -1 : 1, 1, opac_color)
	end
	
	def opac_color
		if @color.nil?
			col = Color.rgba(255, 0, 0, @opacity)
			col.saturation = 0
			@color = col
		end
		if @color.alpha != @opacity
			@color.alpha = @opacity
		end
		@color
	end
	
	def on_screen?
		return false if !@bitmap || @opacity <= 0 || !@visible
		screen = $main_window.rect
		sprite = self.rect
		return screen.intersects?(sprite)
	end
	
	def disposed?
		@disposed
	end
	
	def dispose
		Graphics.remove_sprite(self)
		@disposed = true
	end
	
	def rect
		@rect ||= (
		x = (@mirror ? (@x + @bitmap.width) : @x)
		y = @y
		sprite = Rect.new(x, y, @bitmap.width, @bitmap.height))
		@rect.x = self.x
		@rect.y = self.y
		@rect
	end
end