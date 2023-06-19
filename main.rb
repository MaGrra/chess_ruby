# frozen_string_literal: true

require_relative './lib/board'
require_relative './lib/game'
require_relative './lib/general'


puts "\nWelcome to a game of Chess!\n\n".bold
puts ' Enter one of the following  '
puts '        1 - New Game         '
puts '        2 - Load Game        '

player_choice = gets.chomp.to_i
until (1..2).include?(player_choice)
  puts 'That does not look like 1 or 2... '
  player_choice = gets.chomp.to_i
end

game = player_choice == 1 ? Game.new.play_game : Global::load_game.play_game


