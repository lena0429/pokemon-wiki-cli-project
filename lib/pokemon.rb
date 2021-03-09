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

    def self.display_pokemon
        self.all.each do |pokemon|
            puts "#{pokemon.name.upcase}".colorize(:magenta)
            puts "  height:".colorize(:light_blue) + " #{pokemon.height}"
            puts "  weight:".colorize(:light_blue) + " #{pokemon.weight}"
            puts "  id:".colorize(:light_blue) + " #{pokemon.id}"
            puts "  order:".colorize(:light_blue) + " #{pokemon.order}"
            puts "  base_experience:".colorize(:light_blue) + " #{pokemon.base_experience}"
            puts "  moves:".colorize(:light_blue) + " #{pokemon.moves.join(", ")}"
            puts "  abilities:".colorize(:light_blue) + " #{pokemon.abilities.join(", ")}"
            puts "  forms:".colorize(:light_blue) + " #{pokemon.forms.join(", ")}"
            puts "  held_items:".colorize(:light_blue) + " #{pokemon.held_items.join(", ")}"
            puts "  location_area_encounters:".colorize(:light_blue) + " #{pokemon.location_area_encounters}"
            puts "-------------------------------------------------------------------------------".colorize(:green)
    end
end

def self.clear
    @@all.clear
end


end
