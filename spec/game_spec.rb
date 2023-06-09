# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }

  describe '#valid_choice' do
    context 'Check if player has a valid input' do
      before do
        choice = 'c8'
        allow(game).to receive(:gets).and_return("#{choice}\n")
      end

      xit 'Return a valid input' do
        expect(game.valid_choice).to eq(%w[c 8])
      end
    end

    context 'returns no if not valid input' do
      xit 'return a no' do
        allow(game).to receive(:gets).and_return('11') # Stub user input: '10' is invalid, '6' is valid
        expect { game.valid_choice }.to output("The format used should be like this c2\n").to_stdout
      end
    end
  end

  describe '#possible_moves' do
    let(:game) { Game.new }
    let(:player1) { Player.new('white') }
    let(:player2) { Player.new('black') }
    let(:board) { Board.new }
    let(:piece) { Pawn.new('white') }

    before do
      game.player1 = player1
      game.player2 = player2
      game.current_player = player1
      game.instance_variable_set(:@board, board)
    end

    it 'returns an array of valid moves' do
      board.move_piece([6, 2], piece)
      valid_moves = [['5', 'b'], ['4', 'b']]
      expected_output = "Your available moves are: #{valid_moves}"

      expect { game.possible_moves(piece.show_available_moves(board), piece) }
        .to output(expected_output).to_stdout
    end

    xit 'returns an empty array when no moves are possible' do
      valid_moves = []
      expected_output = "No moves are possible with this piece"

      expect { game.possible_moves(piece.show_available_moves(board), piece) }
        .to output(expected_output).to_stdout
    end
  end
end
