# frozen_string_literal: true

require_relative './board'
require_relative './pieces_all'
require_relative './pieces_type'
require_relative './player'
require_relative './color'
require_relative './general'

class Game
  attr_accessor :player1, :player2, :current_player, :board

  def initialize
    @board = Board.new
  end

  def setup
    register_players
    set_board
    first_player
  end

  def first_player
    @current_player = @player1.color == 'white' ? @player1 : @player2
  end

  def play_game
    setup
    i = 0
    until i == 10
      
      make_move
      i += 1
    end
  end

  def make_move
    puts "\It's #{@current_player.name}'s move! Chose which piece to move!"
    puts 'Example - c2'
    piece = get_input
    
    moves = piece.show_available_moves(@board)
    moves = possible_moves(moves, piece) #updates available
    return if moves.nil?
    puts "Where do you want to move this #{piece.class.name}?"
    move(piece)
    puts "The #{check_king} king is in check" unless check_king.nil?
    @current_player = switch_players
  end

  def check_king
    moves = []
    workboard = @board.fetch_board
    king = @board.fetch_king_loc(@current_player)
    workboard.each_with_index do |row, i|
      row.each_with_index do | cell , j|
        current_piece = @board.fetch_piece([i, j]) if workboard[i][j].is_a?(Piece) &&  workboard[i][j].color == @current_player.color
        moves << current_piece.show_available_moves(@board) unless current_piece.nil? || current_piece.show_available_moves(@board).empty?
        
      end
    end
    return king.color if moves.flatten(1).include?(king.location)

  end

  def get_input
      piece = @board.fetch_piece(valid_choice)
        if is_valid_piece?(piece)
          return piece
        else 
          get_input
        end
  end

  def move(piece)
    new_location = valid_choice
    if piece.show_available_moves(@board).include?(new_location)
      @board.move_piece(new_location, piece)
    else
      puts "Please choose one of the possible locations - #{piece.return_available_moves}"
      move(piece)
    end
  end

  def possible_moves(moves, piece)
    result = []
    moves.each do |move|
      location_piece = @board.fetch_piece(move)
      unless location_piece.instance_variable_get(:@color) == @current_player.color
        result << [Global::NUMBERS.key(move[1]), (move[0] + 1).to_s].join
      end
    end
    if result.empty?
        puts "No moves are possible with this piece".bold
        return nil
    else 
        print 'Your available moves are: '
        puts "#{result}".bold
        piece.update_moves(result)
        result
    end
  end


  def is_valid_piece?(piece)
    if piece.is_a?(Piece) && piece.instance_variable_get(:@color) == @current_player.color
      puts "You have chosen a #{piece.instance_variable_get(:@color)} #{piece.class.name} "
      piece
    else
      puts "Please choose #{@current_player.color} pieces #{@current_player.name}".bold
      return nil
    end
  end

  def valid_choice
    choice = gets.chomp.downcase.chars
    return result = [choice[1].to_i - 1, Global::NUMBERS[choice[0]]] unless correct_input?(choice) == false
    puts "The format used should be like this c2\n"
    valid_choice
  end

  def correct_input?(choice)
    return false if choice.length != 2
    return false unless %w[a b c d e f g h].include?(choice[0])
    return false unless choice[1].to_i.between?(1, 8)

    true
  end

  def switch_players
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def set_board
    @board.starting_locations(@player1)
    @board.starting_locations(@player2)
    @board.print_board
  end

  def register_players
    puts "Press 1 to play Human vs Human\n"
    puts "Press 2 to play Human vs Computer\n\n"
    answer = gets.chomp.to_i
    if answer == 1
      puts "\nYou have chosen to play Human vs Human\n\n"
      sleep(0.5)
      set_players(answer)
    elsif answer == 2
      puts "\nYou have chosen to play vs Computer\n\n"
      sleep(0.5)
      set_players(answer)
    else
      puts 'Please press 1 OR 2'.bold
      register_players
    end
  end

  def set_players(game_type)
    if game_type == 1
      puts 'Enter name for starting player (WHITE)'
      @player1 = Player.new(gets.chomp, 'white')
      puts 'Enter name for other player (BLACK)'
      @player2 = Player.new(gets.chomp, 'black')

    else
      puts 'Enter your name'
      name = gets.chomp
      color = valid_color_input
      @player1 = Player.new(name, color, true)
      pc_color = color == 'white' ? 'black' : 'white'
      @player2 = Player.new('Computer', pc_color, true)
    end
  end

  def valid_color_input
    puts 'Enter which color you want to use'
    color = gets.chomp.downcase
    if %w[white black].include?(color)
      sleep(0.5)
      puts "You choose #{color}".bold
      color
    else
      valid_color_input
    end
  end
end
