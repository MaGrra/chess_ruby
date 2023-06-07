require_relative './board'
require_relative './player'

class Piece
    attr_reader :color
    attr_accessor :location

    def initialize(color, location)
        @color = color
        @location = location
        @available_moves = []
    end
    
    def possible_locations
        p "lol #{self}"
        p self.instance_variable_get(:@available_moves)
    end

    def update_location(new_location)
        @location = new_location
        p @location
    end



end