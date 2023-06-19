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
    @winner = nil
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
    until game_over?
      update_available_all
        make_move
    end
end

  def game_over?
    return true if @winner == @player1 || @winner == player2
  end

  def update_available_all
    workboard = @board.fetch_board
    workboard.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if cell.is_a?(Piece) && cell.color == @current_player.color
          piece = cell
          moves = piece.show_available_moves(@board) 
          moves = possible_moves(moves, piece) #updates available moves
          
        end

      end
    end

  end



  def make_move
    puts "\It's #{@current_player.name}'s move! Chose which piece to move! OR type 'sur' to surrender"
    puts 'Example - c2'

    piece = get_input
    return if piece.nil?
    puts " Your available moves are: #{piece.available_moves}".red
    
    puts "Where do you want to move this #{piece.class.name}? or type 'cancel' to choose different piece"
    return if move(piece).nil?
    puts "The #{check_king} king is in check".bold.red unless check_king.nil?
    kings_left?
    @current_player = switch_players
  end

    def kings_left?
      moves = []
      other_player = @current_player == @player1 ? @player2 : @player1
      workboard = @board.fetch_board
      king = @board.fetch_king_loc(@current_player)
      workboard.each_with_index do |row, i|
        row.each_with_index do | cell , j|
          current_piece = @board.fetch_piece([i, j]) if workboard[i][j].is_a?(Piece) &&  workboard[i][j].color == @current_player.color
          moves << current_piece.location unless current_piece.nil? 
        end
      end
   
      if moves.include?(king.location)
        puts "The winner is #{@current_player.name}.".bold
        @winner = @current_player 
      else 
        return
      end
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
    player_input = valid_choice if @current_player.computer_game == false
    player_input = computer_choice if @current_player.computer_game == true
      if player_input == 'sur'
        @winner = switch_players
        puts "The winner is #{@winner.name} by surrender"
      else
        piece = @board.fetch_piece(player_input)
          if is_valid_piece?(piece)
            return piece
          else 
            get_input
          end
      end
  end

  def computer_choice
    possible = []
    workboard = @board.fetch_board
    workboard.each_with_index do |row, i|
      row.each_with_index do | cell , j|
        if cell.is_a?(Piece) && cell.color == @current_player.color && !cell.available_moves.empty?
          possible << cell.location

        end

      end
    end
    possible.sample
  end



  def move(piece)
    if @current_player.computer_game == false
      new_location = valid_choice
    else
      computer = piece.available_moves.sample
      computer.split()
      new_location = [computer[1].to_i - 1, Global::NUMBERS[computer[0]]]
      sleep(0.5)
    end
    return if new_location == 'cancel'
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
        return nil
    else 
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
    return choice.join if choice.join == 'sur'
    return choice.join if choice.join == 'cancel'
    return result = [choice[1].to_i - 1, Global::NUMBERS[choice[0]]] unless correct_input?(choice) == false
    puts "The format used should be like this c2\n"
    valid_choice
  end


  def correct_input?(choice)
    return true if choice == 'sur'
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
      puts 'Enter your name. You will be playing white'
      name = gets.chomp
      @player1 = Player.new(name, 'white')
      @player2 = Player.new('Computer', 'black', true)
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
