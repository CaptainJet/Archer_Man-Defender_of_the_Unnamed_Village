class Enemy < CharacterBase
	
	attr_accessor :hp, :level
	
	def update
		super
		if @hp <= 0
			die
		end
	end
	
	def die
		$data[:slain] += 1
		$data[:score] += (@level.to_i + 1) * 50
		$data[:souls] += 1
		dispose
	end
end