# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
# require "json"
# require "open_uri"

puts "Cleaning DB..."

Movie.destroy_all

puts "Creating movies..."

Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)

api_url = "https://tmdb.lewagon.com/movie/top_rated"
url_root_image = "https://image.tmdb.org/t/p/w500"

# Note: by default, the api returns page 1
# we can access the rest of the pages with https://tmdb.lewagon.com/movie/top_rated?page=250
# so, if we want to download more films, just need to loop from 1 to N the below code

min_page = 1
max_page = 20

for i in min_page..max_page
  api_info = JSON.parse(URI.parse(api_url + "?page=" + i.to_s).read)
  puts "#{(max_page - i)} seconds"
  api_info["results"].each do |movie|
    movie_title = movie["title"]
    movie_overview = movie["overview"]
    movie_poster_url = url_root_image + movie["backdrop_path"]
    movie_rating = movie["vote_average"].round(1)
    Movie.create(title: movie_title, overview: movie_overview, poster_url: movie_poster_url, rating: movie_rating)
  end
end

puts "#{Movie.count} movies created"
