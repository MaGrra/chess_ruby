require_relative './color'
require_relative './pieces_type'

class Board

    def initialize
        new_board
    end

    def new_board
        rows = 8
        columns = 8
        @board = Array.new(rows) { Array.new(columns) }
        @board.each_with_index do | row, i |
            row.each_with_index do | cell, j |
                @board[i][j] = (i+j).even? ? '   '.bg_gray : '   '.bg_black
            end
        end
    end

    def starting_locations(color)
      starting_pawn(color)
      starting_other(color)
    end

    def starting_other(color)
      @board[7] = [
        Rook.new(color, [7, 0]),
        Knight.new(color, [7, 1]),
        Bishop.new(color, [7,2]),
        Queen.new(color, [7, 3]),
        King.new(color, [7,4]),
        Bishop.new(color, [7,5]),
        Knight.new(color, [7, 6]),
        Rook.new(color, [7, 7])
      ]
    end

    def starting_pawn(color)
      8.times do |index|
        @board[6][index] =
        Pawn.new(color, [6, index])
      end
    end

    def background_color(piece)
      y, x = piece.location
      (x+y).even? ? piece.symbol.black.bg_gray : piece.symbol.gray.bg_black
    end

    def print_board
        printed = []
        @board.each do |row|
          temp_row = []
          row.each do |cell|
            cell = cell.is_a?(Piece) ? background_color(cell) : cell
            temp_row << cell
          end
          printed << temp_row
        end
        puts "   A  B  C  D  E  F  G  H "
        printed.each_with_index do  |row, id| 
          print "#{id+1} "
          puts row.join
        end 
      end

end



