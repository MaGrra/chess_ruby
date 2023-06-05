require_relative './pieces_all'
require_relative './board.rb'

class Pawn < Piece
attr_reader :symbol, :location
    def initialize(color, location)
        @color = color
        @location = location
        color == 'white' ? @symbol = ' ♙ ' : @symbol = ' ♟︎ '
        @available_moves = []
    end

end

class Rook < Piece
attr_accessor :symbol, :location

    def initialize(color, location)
        @color = color
        @location = location
        color == 'white' ? @symbol = ' ♖ ' : @symbol = ' ♜ '
        @available_moves = []
    end

end

class Knight < Piece
    attr_reader :symbol, :location

    MOVES = [
        [1, 2], [-1, 2], [1, -2], [-1, -2],
        [2, 1], [2, -1], [-2, 1], [-2, -1]
      ].freeze
    
        def initialize(color, location)
            @color = color
            @location = location
            color == 'white' ? @symbol = ' ♘ ' : @symbol = ' ♞ '
            @available_moves = []
        end

        def show_available_moves
            moves = []
            MOVES.each do |move|
                x = move[0] + @location[0]
                y = move[1] + @location[1]
                moves << [x, y] if  x.between?(0, 7) && y.between?(0, 7)
            end
            moves
        end

        def update_moves(moves)
            @available_moves = moves
        end

        def delete
            self.delete
        end

    
    end

class Bishop < Piece
    attr_reader :symbol, :location
    
        def initialize(color, location)
            @color = color
            @location = location
            color == 'white' ? @symbol = ' ♗ ' : @symbol = ' ♝ '
            @available_moves = []
        end
    
    end

class Queen < Piece
    attr_reader :symbol, :location
    
        def initialize(color, location)
            @color = color
            @location = location
            color == 'white' ? @symbol = ' ♕ ' : @symbol = ' ♛ '
            @available_moves = []
        end
    
    end


class King < Piece
    attr_reader :symbol, :location
    
        def initialize(color, location)
            @color = color
            @location = location
            color == 'white' ? @symbol = ' ♔ ' : @symbol = ' ♚ '
            @available_moves = []
        end
    
    end