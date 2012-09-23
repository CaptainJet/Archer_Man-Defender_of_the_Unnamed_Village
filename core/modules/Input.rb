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
		@gosu_keys << key
	end
end

# Archer Man: Defender of the Unnamed Village
# Copyright (C) 2012 Robert Rowe
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.