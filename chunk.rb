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

      def bombed?
        @bombed
      end

      def flagged?
        @flagged
      end

      def explored?
        @explored
      end

      def plant_bomb
        @bombed = true
      end

      def toggle_flag
        @flagged = !@flagged unless @explored
      end

      def explore
        return self if explored?
        @explored = true 
        if !bombed? && adjacent_bomb_count == 0
            neighbors.each(&:explore)
        end
        self
      end
end