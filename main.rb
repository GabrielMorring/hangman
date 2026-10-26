require_relative "lib/game"
require_relative "lib/dictionary"

require "json"

def from_file
  unless Dir.exist? "saves"
    puts "No saved games to load. Starting new game."
    Game.new.play
    return
  end

  puts ""

  Dir.entries("saves").each do |file|
    puts file.delete_suffix(".json") if file != "." && file != ".."
  end

  puts "\nEnter a name to load"

  loop do
    name = "#{gets.chomp.strip}.json"

    unless valid_name?(name)
      puts "That is not a valid name"
      next
    end

    File.delete("saves/#{name}") if Game.load_game(name).play
    break
  end
  Dir.rmdir("saves") if Dir.empty?("saves")
end

def valid_name?(name)
  Dir.entries("saves").include?(name)
end

puts "1. New Game"
puts "2. Load Game"

choice = gets.chomp.strip

if choice == "1"
  Game.new.play
elsif choice == "2"
  from_file
else
  puts "Must enter 1 or 2"
end
