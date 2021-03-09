require 'colorize'
require 'pry'

class Cli

   @@topics = []

  def start
    puts "Which of the following pokemon do you want to check? Please enter 1-30:".colorize(:green)
    self.display_topics
    input = gets.chomp
    index = input_to_index(input)

    if !index.between?(0,29)
      puts "Please select a number between 1 and 30:".colorize(:red)
      self.start
    end

    query = Cli.topics[index]
    api = Api.new(query)
    pokemon = api.create_pokemon
    self.display_pokemon(pokemon)
    self.another_selection
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
    all_names = Api.fetch_all_names_from_index_page
    @@topics = all_names
    @@topics
  end

  def display_topics 
   Cli.topics.each_with_index { |topic, index| puts "#{index + 1}. #{topic.capitalize}".colorize(:cyan) }
  end

  def display_pokemon(pokemon)
    puts "#{pokemon[0][:name].upcase}".colorize(:magenta)
            puts "  height:".colorize(:light_blue) + " #{pokemon[0][:height]}"
            puts "  weight:".colorize(:light_blue) + " #{pokemon[0][:weight]}"
            puts "  id:".colorize(:light_blue) + " #{pokemon[0][:id]}"
            puts "  order:".colorize(:light_blue) + " #{pokemon[0][:order]}"
            puts "  base_experience:".colorize(:light_blue) + " #{pokemon[0][:base_experience]}"
            puts "  moves:".colorize(:light_blue) + " #{pokemon[0][:moves].join(", ")}"
            puts "  abilities:".colorize(:light_blue) + " #{pokemon[0][:abilities].join(", ")}"
            puts "  forms:".colorize(:light_blue) + " #{pokemon[0][:forms].join(", ")}"
            puts "  held_items:".colorize(:light_blue) + " #{pokemon[0][:held_items].join(", ")}"
            puts "  location_area_encounters:".colorize(:light_blue) + " #{pokemon[0][:location_area_encounters]}"
            puts "-------------------------------------------------------------------------------".colorize(:green)
      end   
    

  def another_selection
  puts "Would you like to review an another pokemon? (yes/no)"
  input = gets.chomp
  case input
  when "yes"
    Pokemon.clear
    self.start
  when "no"
    puts "Goodbye!"
  else
    puts "Please type in a valid input: yes or no:".colorize(:red)
    self.another_selection

  end
end

end