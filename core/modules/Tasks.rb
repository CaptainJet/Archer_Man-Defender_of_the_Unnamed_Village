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
		@tasks.push(Task.new(time, block))
	end
	
	def new_task_loop(time, &block)
		@loop_tasks.push(Task.new(time, block))
	end
	
	def update
		return if (@pause ||= false)
		@tasks.each_with_index {|task, i|
			task.update
			@tasks[i] = nil if task.called
		}
		@tasks.compact! if @tasks.include?(nil)
		@loop_tasks.each {|a|
			a.update
			a.reset if a.called
		}
	end
	
	def clear
		@tasks = []
		@loop_tasks = []
	end
	
	def pause
		@pause = true
	end
	
	def unpause
		@pause = false
	end
end