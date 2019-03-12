require 'rest-client'
require 'json'
require 'pry'

def response_hash(page_number)
  #make the web request
  response_string = RestClient.get("https://www.swapi.co/api/people/?page=#{page_number}")
  response_hash = JSON.parse(response_string)
end

def characters_on_page(page_number)
  characters = []
  response_hash(page_number)["results"].each do |character_hash|
    characters << character_hash["name"]
  end
  characters
end

#characters_on_page(2)

def get_page_number(character_name) #return the page number
  page_number = 1
  until characters_on_page(page_number).include?(character_name)
    page_number += 1
  end
  page_number
end

#get_page_number("Wilhuff Tarkin")


def get_character_movies_from_api(character_name)
  page_number = get_page_number(character_name)
  response_hash = response_hash(page_number)
  #return the character hash from API
  character_hash = response_hash["results"].find do |character_hash|
    character_hash["name"] == character_name
  end
  #return array of hashes of movie info
  character_movies_hash = character_hash["films"].map do |url|
    url_response_string = RestClient.get(url)
    JSON.parse(url_response_string)
  end
  character_movies_hash
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  film_titles = films.map do |x|
    "⚡️"+x["title"].yellow
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
