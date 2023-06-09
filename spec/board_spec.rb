require './lib/board'

describe Board do
    subject(:board) { described_class.new }

    describe '#get_rook_moves' do 
        context 'when there are empty spaces in the given direction' do
        it 'returns an array of valid moves' do
            allow(board).to receive(:[]) do |x, y|
            # Simulate an empty space on the board
            double(is_a?: false)
            end
    
            # Mock the board dimensions and the current position
            allow(board).to receive(:size).and_return(8)
            x = 3
            y = 3
    
            move = [1, 0]
            expected_moves = [[4, 3], [5, 3], [6, 3], [7, 3]]
    
            moves = get_rook_moves(move, x, y)
            expect(moves).to eq(expected_moves)
        end
        end
    
        context 'when a piece is encountered' do
        xit 'stops and returns the valid moves before the piece' do
            allow(board).to receive(:[]) do |x, y|
            if x == 5 && y == 3
                # Simulate a piece at position [5, 3]
                double(is_a?: true)
            else
                # Simulate an empty space on the board
                double(is_a?: false)
            end
            end
    
            # Mock the board dimensions and the current position
            allow(board).to receive(:size).and_return(8)
            x = 3
            y = 3
    
            move = [1, 0]
            expected_moves = [[4, 3]]
    
            moves = get_rook_moves(move, x, y)
            expect(moves).to eq(expected_moves)
        end
        end
    
        context 'when reaching the edge of the grid' do
        xit 'stops and returns the valid moves before the edge' do
            allow(board).to receive(:[]) do |x, y|
            # Simulate an empty space on the board
            double(is_a?: false)
            end
    
            # Mock the board dimensions and the current position
            allow(board).to receive(:size).and_return(8)
            x = 7
            y = 3
    
            move = [1, 0]
            expected_moves = []
    
            moves = get_rook_moves(move, x, y)
            expect(moves).to eq(expected_moves)
        end
        end
    end
end