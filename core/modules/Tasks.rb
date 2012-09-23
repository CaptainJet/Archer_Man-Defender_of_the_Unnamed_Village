module Tasks

	class Task
	
		attr_accessor :time, :block, :called
		
		def initialize(time, block)
			@time = time
			@orig_time = time
			@block = block
			@called = false
		end
		
		def update
			@time = [@time - 1, 0].max
			(@block.call; @called = true) if @time == 0
		end
		
		def reset
			@time = @orig_time
			@called = false
		end
	end

	@tasks = []
	@loop_tasks = []

	module_function
	
	def new_task(time, &block)
		@tasks.push << Task.new(time, block)
	end
	
	def new_task_loop(time, &block)
		@loop_tasks << Task.new(time, block)
	end
	
	def update
		return if (@pause ||= false)
		@tasks.each_with_index {|task, i|
			task.update
			@tasks[i] = nil if task.called
		}
		@tasks.compact! if @tasks.include?(nil)
		@loop_tasks.cycle(1) {|a|
			a.update
			a.reset if a.called
		}
	end
	
	def clear
		@tasks.clear
		@loop_tasks.clear
	end
	
	def pause
		@pause = true
	end
	
	def unpause
		@pause = false
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