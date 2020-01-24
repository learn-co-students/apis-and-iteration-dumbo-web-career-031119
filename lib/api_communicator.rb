require 'rest-client'
require 'json'
require 'pry'
require 'httparty'

def get_character_movies_from_api(character_name)
  #make the web request

movie_array = ""
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  find_urls = response_hash["results"].map do|characters|
      if characters["name"] == character_name
        movies_url = characters["films"]
        movie_array = movies_url.map do |url|
           HTTParty.get(url)
         end
       end
     end
    movie_array
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



def print_movies(films)

   pull_movie_titles = films.map do |hash|

      "👾 " + hash["title"]


#puts movie_titles
  # some iteration magic and puts out the movies in a nice list
  end
  puts pull_movie_titles
end




def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
