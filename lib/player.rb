
class Player
attr_reader :color, :name
    def initialize(name, color, computer_game = false)
        @name = name
        @color = color
        @computer_game = computer_game
    end

end