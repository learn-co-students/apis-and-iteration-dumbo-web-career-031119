require 'rest-client'
require 'json'
require 'pry'

require 'rest-client'
require 'json'
require 'pry'



def get_character_movies_from_api(character_name)
  movies_arr = []
  i = 0
    all_characters = RestClient.get('http://www.swapi.co/api/people/')
    response_hash = JSON.parse(all_characters)

    found_character = response_hash["results"].find do |character|
      character["name"].downcase == character_name
    end

    movies_arr = found_character["films"].map do |film_api|
      i += 1
      JSON.parse(RestClient.get(film_api))
    end
    return movies_arr
  end

  def print_movies(films)
    film_titles = films.map do |titles|
      titles["title"]
    end
    puts film_titles
  end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
