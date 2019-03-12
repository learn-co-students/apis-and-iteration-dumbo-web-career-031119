require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  movies_arr = []
  movies_hash_arr = []
  response_hash.each do |key, value|
    if key == "results"
      value.each do |info|
        if info["name"].downcase == character_name
          movies_arr.concat(info["films"])
        end
      end
    end
  end

  # Now making web requests from the movie urls
  movies_arr.each do |film|
    film_response = RestClient.get(film)
    film_hash = JSON.parse(film_response)
    movies_hash_arr.push(film_hash)
  end
  movies_hash_arr
  # binding.pry
  # 0
end

# get_character_movies_from_api("Luke skywalker")

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each_with_index do |hash, index|
    puts "#{index + 1}. Title: #{hash['title']}"
    # There's prob a director and producer for every movie but making sure just in case
    if !hash["director"]
      puts "Director: No Director"
    else
      puts "Director(s): #{hash['director']}"
    end
    if !hash["producer"]
      puts "Producer: No Producer"
    else
      puts "Producer(s): #{hash['producer']}"
    end
    puts "Release Date: #{hash['release_date']}"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
