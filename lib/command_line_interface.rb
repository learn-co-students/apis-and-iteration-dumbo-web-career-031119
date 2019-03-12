def welcome
  # puts out a welcome message here!
  puts 'welcome to the Star Wars characters search'
end

def get_character_from_user
  puts 'please enter a character name'
  # use gets to capture the user's input. This method should return that input, downcased.
  gets.chomp.split.map{|x| x.capitalize}.join(" ")
end
