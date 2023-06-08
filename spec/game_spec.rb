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

      it 'Return a valid input' do
        expect(game.valid_choice).to eq(%w[c 8])
      end
    end

    context 'returns no if not valid input' do
      it 'return a no' do
        allow(game).to receive(:gets).and_return('11') # Stub user input: '10' is invalid, '6' is valid
        expect { game.valid_choice }.to output("The format used should be like this c2\n").to_stdout
      end
    end
  end
end
