class Board
  attr_reader :seed_value

  def initialize(width, height, seed_value)
    @grid = Array.new(height) { Array.new(width) { [] } }
    @seed_value = seed_value
  end

  DIRECTIONS = [
    [-1, 1],
    [0, 1],
    [1, 1],
    [1, 0],
    [1, -1],
    [0, -1],
    [-1, -1],
    [-1, 0]
  ].freeze

  def render_grid!
    @grid.each do |row|
      row.each do |el|
        print el.first
      end
      puts ''
    end
  end

  def seed!
    @grid.each do |row|
      row.each do |el|
        chance = 1 + rand(seed_value)
        if chance == 1
          el << '██'
        else
          el << '  '
        end
      end
    end
  end

  def next_generation
    new_grid = Array.new(@grid.length) { Array.new(@grid.first.length) { [] } }

    @grid.each_with_index do |row, k|
      row.each_index do |j|
        neighbor_count = count_live_neighbors([k, j])

        if @grid[k][j].first == '██'
          if neighbor_count < 2 || neighbor_count > 3
            new_grid[k][j] = ['  ']
          else
            new_grid[k][j] = ['██']
          end
        elsif @grid[k][j].first == '  '
          if neighbor_count == 3
            new_grid[k][j] = ['██']
          else
            new_grid[k][j] = ['  ']
          end
        end
      end
    end

    @grid = new_grid
  end

  def count_live_neighbors(pos)
    x, y = pos
    count = 0

    DIRECTIONS.each do |direction|
      a, b = direction
      new_h = x + a
      new_v = y + b

      if exists_on_board?([new_h, new_v])
        count += 1 if @grid[new_h][new_v].first == '██'
      end
    end

    count
  end

  def exists_on_board?(pos)
    x, y = pos

    if x < 0 || y < 0 || x > @grid.length - 1 || y > @grid.first.length - 1
      return false
    end

    true
  end
end
