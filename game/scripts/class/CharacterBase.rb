class CharacterBase < Character
	
	attr_reader :row
	
	def initialize(ops = {})
		super(ops)
		@row ||= 1
		@rows = []
		size = @bitmaps.size / 4
		@rows = [@bitmaps[0...size], @bitmaps[size...(size*2)], @bitmaps[(size*2)...(size*3)], @bitmaps[(size*3)...(size*4)]]
		@bitmaps = @rows[@row]
		@bitmap = @bitmaps[0]
	end
	
	def row=(i)
		index = @bitmaps.index(@bitmap)
		@bitmaps = @rows[i]
		@row = i
		@bitmap = @bitmaps[index]
	end
	
	def reset
		@bitmap = @bitmaps[0]
	end
end