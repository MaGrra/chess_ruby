# frozen_string_literal: true

require_relative './lib/board'
require_relative './lib/game'

puts 'Welcome to a game of chess'

test1 = Game.new
test1.play_game
