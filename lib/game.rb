require_relative './board'
require_relative './pieces_all'
require_relative './pieces_type'
require_relative './player'
require_relative './color'

class Game
attr_accessor :player1, :player2

    def initialize
        @board = Board.new
        setup
    end

    def setup
        register_players
        
        @board.starting_locations(@player1)
        @board.starting_locations(@player2)
        @board.print_board
    end

    def register_players
        puts "Press 1 to play Human vs Human"
        puts "Press 2 to play Human vs Computer"
        answer = gets.chomp.to_i
        if answer == 1
            puts "You have chosen to play Human vs Human"
            sleep(0.5)
            set_players(answer)
        elsif answer == 2
            puts "You have chosen to play vs Computer"
            sleep(0.5)
            set_players(answer)
        else 
            puts "Please press 1 OR 2"
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