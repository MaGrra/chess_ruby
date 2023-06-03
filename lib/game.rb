require_relative './board'
require_relative './pieces_all'
require_relative './pieces_type'
require_relative './player'
require_relative './color'
require_relative './general'

class Game
attr_accessor :player1, :player2, :current_player



    def initialize
        @board = Board.new
    end

    def setup
        register_players 
        set_board
        first_player
    end

    def first_player
        @player2.color == 'white' ? @current_player = @player1 : @current_player = @player2
    end

    def play_game
        setup
        @current_player = switch_players
        make_move
    end

    def make_move
        puts "\It's #{@current_player.name}'s move! Chose which piece to move!"
        puts "Example - c2"
        piece = @board.fetch_piece(valid_choice)
        is_valid_piece?(piece)
        puts "Your available moves are: #{possible_moves(piece.show_available_moves, piece)}"

    end

    def possible_moves(moves, piece)
        result = []
        moves.each do | move |
            location_piece = @board.fetch_piece(move)
            unless location_piece.instance_variable_get(:@color) == @current_player.color
                result << [move[0]+1, Global::NUMBERS.key(move[1])]
            end
        end
        piece.update_moves(result)
    end

    def is_valid_piece?(piece)
        if piece.is_a?(Piece) && piece.instance_variable_get(:@color) == @current_player.color
            puts "You have chosen a #{piece.instance_variable_get(:@color)} #{piece.class.name}"
            piece
        else
            puts "Please choose #{@current_player.color} pieces #{@current_player.name}".bold
            make_move
        end
    end


    def valid_choice
        choice = gets.chomp.downcase.chars
        if correct_input?(choice) == false
          puts "The format used should be like this c2\n"
          valid_choice
        else
          return result = [choice[1].to_i - 1, Global::NUMBERS[choice[0]]]
        end
      end

      def correct_input?(choice)
        return false if choice.length != 2
        return false unless ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'].include?(choice[0])
        return false unless choice[1].to_i.between?(1, 8)
        
        true
      end

    def switch_players
        @current_player == @player1 ? @player2 : @player1
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
            puts "Please press 1 OR 2".bold
            register_players
        end
    end

    def set_players(game_type)
        if game_type == 1
            puts "Enter name for starting player (WHITE)"
            @player1 = Player.new(gets.chomp, "white")
            puts "Enter name for other player (BLACK)"
            @player2 = Player.new(gets.chomp, "black")

        else
            puts "Enter your name"
            name = gets.chomp
            color = valid_color_input
            @player1 = Player.new(name, color, true)
            color == 'white' ? pc_color = 'black' : pc_color = 'white'
            @player2 = Player.new('Computer', pc_color, true)
        end
    end

    def valid_color_input
        puts "Enter which color you want to use"
        color = gets.chomp.downcase
        if ['white', 'black'].include?(color)
            sleep(0.5)
            puts "You choose #{color}".bold
            color
        else
            valid_color_input
        end
    end


end