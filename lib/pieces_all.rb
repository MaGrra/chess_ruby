# frozen_string_literal: true

require_relative './board'
require_relative './player'

class Piece
  attr_reader :color, :available_moves
  attr_accessor :location

  def initialize(color, location)
    @color = color
    @location = location
    @available_moves = []
  end

  def return_available_moves
    @available_moves
  end

  def update_location(new_location)
    @location = new_location
    @is_moved = true
  end
end
