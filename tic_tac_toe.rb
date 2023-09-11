# frozen_string_literal: true

# Tic Tac Toe Command Line Game

# Player Class
class Player
  attr_accessor :name, :symbol

  def initialize
    begin
      print 'Enter player name: '
      @name = gets.strip
      raise StandardError if !defined?(@name) || @name == ''
    rescue StandardError
      puts 'Invalid name, try again!'
      retry
    end

    @symbol = name[0]
  end

  def make_selection(game)
    begin
      print "#{name}, make a selection: "
      selection = gets.strip.to_i - 1
      raise StandardError if selection.negative? || selection > 9 || !game.valid_selection?(selection)
    rescue StandardError
      puts 'Invalid selection, try again!'
      retry
    end
    game.board_state[selection] = @symbol
    game.print_board
  end
end

# Game Class
class Game
  LINES = [%w[1 2 3], %w[4 5 6], %w[7 8 9], %w[1 4 7], %w[2 5 8], %w[3 6 9], %w[1 5 9], %w[3 5 7]].freeze
  attr_accessor :board_state, :current_player, :win_condition

  def initialize(first_player)
    @board_state = %w[1 2 3 4 5 6 7 8 9]
    print_board
    @current_player = first_player
  end

  def print_board
    puts board_state[0..2].join(' | ')
    puts '---------'
    puts board_state[3..5].join(' | ')
    puts '---------'
    puts board_state[6..8].join(' | ')
    puts ''
  end

  def valid_selection?(selection)
    LINES.any? { |line| line.include?(board_state[selection]) }
  end

  def game_over?
    LINES.each do |line|
      if line.none? { |e| board_state.include?(e) }
        @win_condition = line.all? { |e| board_state[e.to_i - 1] == @current_player.symbol }
      end
    end

    @win_condition
  end

  def draw?
    @win_condition = true if board_state.uniq.size <= 2
  end
end

def play(player1, player2, game)
  until game.win_condition
    game.current_player.make_selection(game)

    puts "#{game.current_player.name} won! Congrats!" if game.game_over?
    puts "It\'s a draw! Game Over." if game.draw?

    game.current_player = if game.current_player == player1
                            player2
                          elsif game.current_player == player2
                            player1
                          end
  end
end

def start_game
  player1 = Player.new
  puts "Hello, #{player1.name}! Your symbol is #{player1.symbol}."
  player2 = Player.new
  puts "Hello, #{player2.name}! Your symbol is #{player2.symbol}."
  game = Game.new(player1)

  play(player1, player2, game)
end

start_game
