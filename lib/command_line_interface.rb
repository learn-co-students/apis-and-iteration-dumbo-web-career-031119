require "colorize"

def welcome
  puts "Welcome to 💥SWAPI (Star Wars API)☄️".red
end

def get_character_from_user
  puts "please enter a character name".cyan
  gets.chomp
  # use gets to capture the user's input. This method should return that input, downcased.
end
