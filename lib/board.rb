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

    def starting_locations(player)
      color = player.color
      color == 'white' ? number = 7 : number = 0
      starting_pawn(color)
      starting_other(color,number)
    end

    def starting_other(color, number)
      @board[number] = [
        Rook.new(color, [number, 0]),
        Knight.new(color, [number, 1]),
        Bishop.new(color, [number,2]),
        Queen.new(color, [number, 3]),
        King.new(color, [number,4]),
        Bishop.new(color, [number,5]),
        Knight.new(color, [number, 6]),
        Rook.new(color, [number, 7])
      ]
    end

    def starting_pawn(color)
      number = 6 if color == 'white'
      number = 1 if color == 'black'

      8.times do |index|
        @board[number][index] =
        Pawn.new(color, [number, index])
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



