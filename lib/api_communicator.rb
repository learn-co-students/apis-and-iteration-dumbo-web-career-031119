require 'httparty'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  # make the web request
  response = HTTParty.get('http://www.swapi.co/api/people/')
  # response_hash = JSON.parse(response_string)
  charInfo = nil
  while charInfo.nil?
    charInfo = response['results'].find { |character| character['name'] == character_name }
    if HTTParty.get(response['next']).nil?
      response = HTTParty.get(response['next'])
    else
      break
    end
  end
  charInfo
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  if films.nil?
    puts "not a valid entry"
    return
  end
  films['films'].map.with_index do |movie, i|
    movie_hash = HTTParty.get(movie)
    puts (i + 1).to_s + ' ' + movie_hash['title']
  end
end

def show_character_movies(character)
  puts character
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
