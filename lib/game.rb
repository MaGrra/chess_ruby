require_relative './board'
require_relative './pieces_all'
require_relative './pieces_type'
require_relative './player'
require_relative './color'

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
        chose_piece(valid_choice)
    end


    def valid_choice
        choice = gets.chomp.chars
        if choice.length != 2 
            puts "The format used should be like this c2\n"
            valid_choice
        else
            return choice
        end
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