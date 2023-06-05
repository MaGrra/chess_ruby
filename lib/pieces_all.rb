require_relative './board'
require_relative './player'

class Piece

    def initialize(color)
        @color = color
        @available_moves = []
    end
    
    def possible_locations
        p "lol #{self}"
        p self.instance_variable_get(:@available_moves)
    end

    def delete
        self.delete
        return
    end

end