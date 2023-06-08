require_relative './pieces_all'
require_relative './board.rb'

class Pawn < Piece
attr_reader :symbol
attr_accessor :location, :is_moved

    MOVES = [[-1, 0]]
    def initialize(color, location)
        @color = color
        @location = location
        color == 'white' ? @symbol = ' ♙ ' : @symbol = ' ♟︎ '
        @available_moves = []
        @is_moved = false
    end

    def show_available_moves(board)
        moves = []
        @color == "white" ? num = -1 : num = 1
        x = @location[0]
        y = @location[1]
        moves << [x + num, y]
        moves << [x + (num * 2), y] if @is_moved == false
        capture = board.pawn_scan(x, y).flatten
        moves << capture unless capture.empty?
        return moves
    end

    def valid_pawn_move?(x, y)
        true if  x.between?(0, 7) && y.between?(0, 7)
    end

    def update_moves(moves)
        @available_moves = moves
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

        def show_available_moves(board)
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