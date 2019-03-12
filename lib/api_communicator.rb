require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  movies_hash_arr = []
  count = 1

  loop do
    #make the web request
    response_string = RestClient.get("http://www.swapi.co/api/people/?page=#{count}")
    response_hash = JSON.parse(response_string)

    movie_hash = response_hash["results"].find do |char|
      char["name"].downcase == character_name
    end

    # There should only be one character with the same name (hopefully)
    if movie_hash != nil
      movies_arr = movie_hash["films"]

      # Now making web requests from the movie urls
      # Can make another helper method here
      #########################################
      movies_hash_arr = movies_arr.map do |film|
        film_response = RestClient.get(film)
        film_hash = JSON.parse(film_response)
      end
      #########################################
    end

    count += 1
    break if response_hash["next"] == nil
  end
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  movies_hash_arr
end

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
