require_relative './color'

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

    def print_board
        printed = []
        @board.each do |row|
          temp_row = []
          row.each do |cell|
            temp_row << cell
          end
          printed << temp_row
        end
        printed.each { |row| puts row.join }
      end

end



