require_relative './pieces_all'
require_relative './board.rb'

class Pawn < Piece
attr_reader :symbol, :location
    def initialize(color, location)
        @color = color
        @location = location
        color == 'white' ? @symbol = ' ♙ ' : @symbol = ' ♟︎ '
    end

end

class Rook < Piece
attr_accessor :symbol, :location

    def initialize(color, location)
        @color = color
        @location = location
        color == 'white' ? @symbol = ' ♖ ' : @symbol = ' ♜ '
    end

end

class Knight < Piece
    attr_reader :symbol, :location
    
        def initialize(color, location)
            @color = color
            @location = location
            color == 'white' ? @symbol = ' ♘ ' : @symbol = ' ♞ '
        end
    
    end

class Bishop < Piece
    attr_reader :symbol, :location
    
        def initialize(color, location)
            @color = color
            @location = location
            color == 'white' ? @symbol = ' ♗ ' : @symbol = ' ♝ '
        end
    
    end

class Queen < Piece
    attr_reader :symbol, :location
    
        def initialize(color, location)
            @color = color
            @location = location
            color == 'white' ? @symbol = ' ♕ ' : @symbol = ' ♛ '
        end
    
    end


class King < Piece
    attr_reader :symbol, :location
    
        def initialize(color, location)
            @color = color
            @location = location
            color == 'white' ? @symbol = ' ♔ ' : @symbol = ' ♚ '
        end
    
    end