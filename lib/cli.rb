require 'colorize'

class Cli

  @@topics = ["bulbasaur", "ivysaur", "venusaur", "charmander", "charmeleon", "charizard", "squirtle", "wartortle", "blastoise", "caterpie", "metapod", "butterfree", "weedle", "kakuna", "beedrill", "pidgey", "pidgeotto", "pidgeot", "rattata", "raticate"]

  def start
    puts "Which of the following pokemon do you want to check? Please enter 1-20:".colorize(:green)
    self.display_topics
    input = gets.chomp
    index = input_to_index(input)

    if !index.between?(0,19)
      puts "Please select a number between 1 and 20:".colorize(:red)
      self.start
    end

    query = Cli.topics[index]
    api = Api.new(query)
    api.create_pokemon
    Pokemon.display_pokemon
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
    @@topics
  end

  def display_topics 
   Cli.topics.each_with_index { |topic, index| puts "#{index + 1}. #{topic.capitalize}".colorize(:cyan) }
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