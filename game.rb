require_relative './board'

class Game
  def initialize(width, height, seed_value)
    @board = Board.new(width, height, seed_value)
    @board.seed!
  end

  def run!
    loop do
      system "clear"
      @board.render_grid!
      @board.next_generation
      sleep(0.1)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  print "Enter the board width: "
  width = gets.chomp.to_i
  print "Enter the board height: "
  height = gets.chomp.to_i
  print "Enter a seed value: "
  seed_value = gets.chomp.to_i
  game = Game.new(width, height, seed_value)
  game.run!
end
