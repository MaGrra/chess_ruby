
require_relative '../lib/game'

describe Game do
    subject(:game) { described_class.new }

    describe '#valid_choice' do
        context 'Check if player has a valid input' do
            before do
                choice = "c2"
                allow(game).to receive(:gets).and_return("#{choice}\n") 
            end

            it 'Return a valid input' do
                expect(game.valid_choice).to eq(["c", "2"])
            end
        end

        context 'returns no if not valid input' do
            it 'return a no' do
                allow(game).to receive(:gets).and_return('ccc') # Stub user input: '10' is invalid, '6' is valid
                expect { game.valid_input }.to output("The format used should be like this c2\n").to_stdout
            end
        end
    end
end


