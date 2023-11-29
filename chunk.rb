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

      attr_reader :pos

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

      def neighbors
        neighboring_coord = AROUND.map do |x, y|
            [pos[0] + x, pos[1] + y]
        end.select do |row, col|
            [row, col].all? do |coord|
                coord.between?(0, @board.grid_size - 1)
            end
            neighboring_coord.map { |pos| @board[pos] }
        end
      end

      def adjacent_bomb_count
        neighbors.select(&:bombed?).count
      end

      def inspect
        { pos: pos,
          bombed: bombed?,
          explored: explored?,
          flagged: flagged?}.inspect
      end

      def render
        if flagged? 
            "F"
        elsif explored?
            adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
        else
            "B"
        end
      end

    def reveal
        if flagged?
            bombed? ? "F" : "f"
        elsif bombed?
            explored? ? "X" : "B"
        else
            adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
        end
    end
end