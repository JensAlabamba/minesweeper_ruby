class Chunk
    
    AROUND = [
        [-1, -1],
        [-1,  0],
        [-1,  1],
        [ 0, -1],
        [ 0,  1],
        [ 1, -1],
        [ 1,  0],
        [ 1,  1]
      ].freeze

      def initialize(board, pos)
        @board = board
        @pos = pos
        @bombed , @flagged, @explored = false, false, false
      end
end