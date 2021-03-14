require 'colorize'

class Pokemon
    attr_accessor :name, :height, :weight, :id, :order, :moves, :abilities, :base_experience, :forms, :held_items, :location_area_encounters

    @@all = []

    def initialize(hash)
        hash.each { |key, value| self.send("#{key}=", value) } 
        @@all << self
    end

    def self.all
        @@all
    end


    def self.find_or_create_pokemon_by_query(query)
        the_pokemon = Pokemon.all.detect { |pokemon| pokemon.name == query }
        if  the_pokemon
            the_pokemon
        else
          api = Api.new(query)
          new_pokemon = api.create_pokemon    
          new_pokemon
        end
      end    

end
