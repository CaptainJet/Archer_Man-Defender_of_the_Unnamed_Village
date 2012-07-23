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

	def self.intersection(a, b)
		x = [a.x, b.x].max
		temp_w = [a.x + a.width, b.x + b.width].min
		y = [a.y, b.y].max
		temp_h = [a.y + a.height, b.y + b.height].min
		if (temp_w >= x) && (temp_h >= y)
			return Rect.new(x, y, temp_w - x, temp_h - y)
		else
			return Rect.new(0, 0, 0, 0)
		end
	end
end