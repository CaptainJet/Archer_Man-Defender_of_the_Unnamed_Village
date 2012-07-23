class Character < Sprite
	
	TIME = 5
	
	attr_accessor :animate, :particle_core
	
	def initialize(ops = {})
		super(ops)
		@t_width ||= 32
		@t_height ||= 32
		@animate ||= true
		@bitmaps = Image.load_tiles($main_window, @bitmap.name, @t_width, @t_height, false)
		@bitmaps = @bitmaps.collect {|a| b = Bitmap.new("", nil, true); b.image = a; b}
		@bitmap = @bitmaps[0]
		@timer = 0
	end
	
	def update
		super
		@timer = [@timer + 1, TIME].min
		if @animate
			if @timer == TIME
				index = @bitmaps.index(@bitmap) + 1
				if index == @bitmaps.size
					@bitmap = @bitmaps[0]
				else
					@bitmap = @bitmaps[index]
				end
				@timer = 0
			end
		else
			@bitmap = @bitmaps[0]
		end
		if @particle_core
			@particle_core.x = self.x + @bitmap.width / 2
			@particle_core.y = self.y + @bitmap.height / 2
			if @particle_core.empty?
				@particle_core = nil
			end
		end
	end
end