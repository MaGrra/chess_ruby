# frozen_string_literal: true

require_relative './color'
require_relative './pieces_type'

class Board
  attr_reader :board
  
  def initialize
    new_board
  end

  def new_board
    rows = 8
    columns = 8
    @board = Array.new(rows) { Array.new(columns) }
    @board.each_with_index do |row, i|
      row.each_with_index do | cell, j|
        @board[i][j] = (i + j).even? ? '   '.bg_gray : '   '.bg_black
      end
    end
  end

  def move_piece(location, piece)
    x, y = location
    @board[x][y] = piece

    i, j = piece.instance_variable_get(:@location)
    @board[i][j] = (i + j).even? ? '   '.bg_gray : '   '.bg_black
    piece.update_location(location)
    print_board
  end

  def fetch_piece(location)
    @board[location[0]][location[1]]
  end

  def starting_locations(player)
    number = if player.computer_game == false
               player.color == 'white' ? 7 : 0
             else
               player.color == 'white' ? 0 : 7
             end
    starting_pawn(player)
    starting_other(player, number)
  end

  def fetch_king_loc(player)
    player.color == "white" ? @king_black : @king_white
  end 

  def fetch_board
    @board
  end 

#x,y - current location
# Gets available moves for Rook, queen, bishop
def get_moves(move, x, y)
  result = []
  next_x = x + move[0]
  next_y = y + move[1]
  current_color = @board[x][y].color

  while next_x >= 0 && next_x <= 7 && next_y >= 0 && next_y <= 7
    if @board[next_x][next_y].is_a?(Piece)
      if @board[next_x][next_y].color != current_color
        result << [next_x, next_y]
        break
      else
        break
      end
    else
      result << [next_x, next_y]
      next_x += move[0]
      next_y += move[1]
    end
  end
  result
end

  def pawn_scan(x, y)
    result = []
    scan_attack = @board[x][y].color == 'white' ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
    scan_attack.each do |loc|
      scan_location = @board[loc[0] + x][loc[1] + y]
      result << scan_location.location if scan_location.is_a?(Piece) && scan_location.color != @board[x][y].color
    end
    result
  end

  #returns location if unaccessable
  def pawn_path_blocked?(x, y)
    path = @board[x][y].color == 'white' ? [-1, 0] : [1, 0]
    scan_location = @board[path[0] + x][path[1] + y]
    return scan_location.location if scan_location.is_a?(Piece)

  end

  def starting_other(player, number)
    @board[number] = [
      Rook.new(player.color, [number, 0]),
      Knight.new(player.color, [number, 1]),
      Bishop.new(player.color, [number, 2]),
      Queen.new(player.color, [number, 3]),
      instance_variable_set("@king_#{player.color}", King.new(player.color, [number, 4])),
      Bishop.new(player.color, [number, 5]),
      Knight.new(player.color, [number, 6]),
      Rook.new(player.color, [number, 7])
    ]
  end

  def starting_pawn(player)
    if player.computer_game == false
      number = 6 if player.color == 'white'
      number = 1 if player.color == 'black'
    else
      number = 1 if player.color == 'white'
      number = 6 if player.color == 'black'
    end

    8.times do |index|
      @board[number][index] =
        Pawn.new(player.color, [number, index])
    end
  end

  def background_color(piece)
    y, x = piece.location
    (x + y).even? ? piece.symbol.black.bg_gray : piece.symbol.gray.bg_black
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
    puts '   A  B  C  D  E  F  G  H '
    printed.each_with_index do |row, id|
      print "#{id + 1} "
      puts row.join
    end
  end
end
