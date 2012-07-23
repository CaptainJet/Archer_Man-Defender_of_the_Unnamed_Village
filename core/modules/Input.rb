module Input
	
	@previous_keys, @keys, @gosu_keys = [], [], []
	
	module_function
	
	def update
		@previous_keys = @keys.dup
		@keys = @gosu_keys.dup
		@gosu_keys.clear
	end
	
	def trigger?(key)
		key = const_get("Kb#{key}")
		return @keys.include?(key) && !@previous_keys.include?(key)
	end
	
	def [](key)
		trigger?(key)
	end
	
	def press?(key)
		key = const_get("Kb#{key}")
		return $main_window.button_down?(key)
		return false
	end
	
	def add_key(key)
		@gosu_keys.push(key)
	end
end