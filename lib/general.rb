# frozen_string_literal: true
public 

module Global
  NUMBERS = {
    'a' => 0,
    'b' => 1,
    'c' => 2,
    'd' => 3,
    'e' => 4,
    'f' => 5,
    'g' => 6,
    'h' => 7
  }.freeze
end

def save_game(game)
  puts 'Chose a name for the save'
  filename = get_save_name
  serialized_object = YAML.dump(game)
  File.open(File.join(Dir.pwd, "/saves/#{filename}.yaml"), 'w') { |file| file.write serialized_object }
end

def get_save_name
  filenames = Dir.glob('saves/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
  filename = gets.chomp
  return filename unless filenames.include?(filename)

  puts 'This name is taken'
  get_save_name
end

def load_game
  filename = available_saves
  return unless filename

  saved = File.open(File.join(Dir.pwd, "saves/#{filename}"), 'r')
  
  loaded_game = begin
    YAML.load(saved, aliases: true, permitted_classes: [Game, Board, Player, Pawn, Knight, Rook, Bishop, King, Queen])
  rescue ArgumentError
    YAML.load(saved, permitted_classes: [Game, Board, Player, Pawn, Knight, Rook, Bishop, King, Queen])
  end
  
  saved.close
  loaded_game
end

def available_saves
  puts 'Chose your save game'
  filenames = Dir.glob('saves/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
  puts filenames
  filename = gets.chomp
  if filenames.include?(filename)
    "#{filename}.yaml"

  else
    puts "\nTheres no such file here!\n\n".bold
    available_saves
  end
end