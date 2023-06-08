# frozen_string_literal: true

class Player
  attr_reader :color, :name, :computer_game

  def initialize(name, color, computer_game = false)
    @name = name
    @color = color
    @computer_game = computer_game
  end
end
