require 'colorize'
require 'pry'

class Cli

   @@topics = []

  def start
    puts "Which of the following Pokémon would you like to learn about? Please enter 1-20:".colorize(:green)
    self.display_topics
    input = gets.strip
    index = input_to_index(input)

    if !index.between?(0,19)
      puts "Please select a number between 1 and 20:".colorize(:red)
      input = gets.strip
      index = input_to_index(input)
    end

    query = Cli.topics[index]
    api = Api.new(query)
    pokemon = Pokemon.find_or_create_pokemon_by_query(query)
    self.display_pokemon(pokemon)
    self.more_selection
  end


  def self.logo
    puts "
               .----------------------------------.
               |                                  |
               |  AMC         .----..        .'.  |
               |   9      _.-~  __   ~~~...'' .'  |
               |   9    .'    .~  '''...  ..''    |
               |       .'   ..''''''..  ''        |
               |       '...'          '..         |
               |      ..'              '.'..      |
               |   ..'  .'               ;  '.    |
               | .'\   :   /~~\       /~~-.__|)     |
               | './__:   ; '. |.''''''..  ;      |
               |     :    `..''()      ()'.'      |
               |     :    .'  __..------_  ;      |
               |      : .  .-~      .  . ~-:      |
               |    _.-'  ;        _____    ).    |
               |   /_     ; `-__-~H     H~-'  '.  |
               |  (  \  _.'.  (_____   _..';._.')  |
               |   '.'~~    ~--...__~~~_.-'   `~  |
               |        ,           ~~~           |
               |     PokeMon # 079 - Slowpoke     |
               `----------------------------------' ".colorize(:cyan)
    puts "
               LEARN MORE ABOUT YOUR FAVORATE POKEMON!".colorize(:light_red)
    puts " ------------------------------------------------------------------------ ".colorize(:cyan)         
  end

  def input_to_index(input)
    input.to_i - 1
  end


  def self.topics
    @@topics = Api.fetch_all_names_from_index_page
    @@topics
  end

  def display_topics 
   Cli.topics.each_with_index { |topic, index| puts "#{index + 1}. #{topic.capitalize}".colorize(:cyan) }
  end

  def display_pokemon(pokemon)
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
      
  def display_all_pokemon
    Pokemon.all.collect do |pokemon|
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


  def more_selection
    puts "What else would you like to do?".colorize(:magenta)
    puts"1. learn about another Pokémon\n2. review all the Pokémon you have learned\n3. quit".colorize(:green)
    input = gets.strip
    case input
      when "1"
        self.start
      when "2"
        self.display_all_pokemon
        self.more_selection
      when "3"
        puts "Have a good day~!\nSee you next time!".colorize(:cyan)  
      else
        puts "Please type in a valid input - 1, 2 or 3:".colorize(:red)
        self.more_selection
      end
  end

end

