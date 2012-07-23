module Graphics

	module_function
	
	@@sprites = []
	
	def update
		@@sprites.each {|a| a.draw }
	end
	
	def add_sprite(sprite)
		@@sprites.push(sprite)
	end
	
	def remove_sprite(sprite)
		@@sprites.delete(sprite)
	end
end