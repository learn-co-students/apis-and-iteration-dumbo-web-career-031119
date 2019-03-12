require 'colorize'
require 'httparty'
require 'pry'

puts String.colors
puts String.modes

def introduce
  puts "Welcome to the book 📖 search".yellow
  puts "What would you like to search for?".blue
end

def get_book_results(search_term)
  query = search_term.split.join("+")
  url = "https://www.googleapis.com/books/v1/volumes?q=#{query}"
  HTTParty.get(url)
end

def process_google_hash(books_array)
  books_array.map do |book_hash|
    {
      title: book_hash["volumeInfo"]["title"],
      authors: book_hash["volumeInfo"]["authors"]
    }
  end
end

def display_results(results)
  puts "Search results:".red

  results.each do |book_result|
    puts title.blue
  end
end

def run
  introduce
  google_books_hash = get_book_results(gets.chomp)["items"]
  titles = process_google_hash(google_books_hash)
  display_results(titles)
end

run
