require_relative './pieces_all'
require_relative './board.rb'

class Pawn < Piece
attr_reader :symbol, :location
    def initialize(color, location)
        @color = color
        @location = location
        @symbol = ' ♙ '
    end


    def place_piece
        
    end

end