require 'pry'
require 'httparty'
require 'json'
require 'colorize'

require_relative 'pokemon.rb'

class Api
    attr_accessor :query

    def initialize(query)
      @query = query
    end

    def self.fetch_all_names_from_index_page
      url1 = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20"
      uri1 = URI(url1)
      response1 = Net::HTTP.get(uri1)
      json1 = JSON.parse(response1)
      arr_1 = (json1["results"].collect{|name|name["name"]})[1..15]

      url2 = "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20"
      uri2 = URI(url2)
      response2 = Net::HTTP.get(uri2)
      json2 = JSON.parse(response2)
      arr_2 = (json2["results"].collect {|name|name["name"]})[1..15]

      arr_1.concat(arr_2)
    end

    def fetch_pokemon
      url = "https://pokeapi.co/api/v2/pokemon/#{query}/"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      json = JSON.parse(response)
      pokemon_array = []
      pokemon_array << {
      :name => json["name"],      
      :height => json["height"],
      :weight => json["weight"],
      :id => json["id"],
      :order => json["order"],
      :moves => (json["moves"].collect {|move| move["move"]["name"]})[1..10],
      :abilities => json["abilities"].collect {|ability| ability["ability"]["name"]},
      :base_experience => json["base_experience"],
      :forms => json["forms"].collect {|form| form["name"]},
      :held_items => json["held_items"].collect {|item| item["item"]["name"]},
      :location_area_encounters => json["location_area_encounters"]
      }
    end

    def create_pokemon
      self.fetch_pokemon.each do |hash|
       Pokemon.new(hash)
      end
    end
  
  end

  