Dir.chdir(File.dirname(__FILE__))

if !system('bundle install')
	if RUBY_PLATFORM =~ /linux/i
		system("sudo gem install bundler")
	else
		system("gem install bundler")
	end
	system('bundle install')
end

puts "Finished Compiling. You may now play the game. Press Enter to exit."
gets