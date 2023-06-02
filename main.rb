require_relative './lib/board'
require_relative './lib/game'

puts "Welcome to a game of chess"
game = Board.new
game.print_board

test1 = Game.new