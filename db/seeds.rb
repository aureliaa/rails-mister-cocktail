# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

Cocktail.destroy_all
Ingredient.destroy_all

url = "http://www.thecocktaildb.com/api/json/v1/1/filter.php?g=Cocktail_glass"
user_serialized = open(url).read
user = JSON.parse(open(url).read)["drinks"].first(20)
user.each do |item|
  new_url = item['strDrinkThumb']
  cocktail = Cocktail.new(name: item["strDrink"])
  cocktail.remote_photo_url = new_url
  cocktail.save
end


ingredients = %w(lemon ice mint leaves redbull jagermeister sugar tonic gin rhum)
ingredients.each do |ingredient|
  Ingredient.create(name:ingredient)
end
