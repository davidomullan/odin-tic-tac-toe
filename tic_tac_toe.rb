# frozen_string_literal: true

# Tic Tac Toe Command Line Game

# Player Class
class Player
  attr_accessor :name, :symbol

  def initialize
    @name = valid_name

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
    game.board_state[selection] = symbol
    game.print_board
  end

  def valid_name
    begin
      print 'Enter player name: '
      desired_name = gets.strip
      raise NameError if Array(0..10).map(&:to_s).any? { |n| n == desired_name[0] }
      raise StandardError if !defined?(desired_name) || desired_name == ''
    rescue NameError
      puts 'Name cannot start with a number, try again!'
      retry
    rescue StandardError
      puts 'Invalid name, try again!'
      retry
    end
    desired_name
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
    any_wins = []
    LINES.each do |line|
      if line.none? { |e| board_state.include?(e) }
        any_wins << line.all? { |e| board_state[e.to_i - 1] == current_player.symbol }
      end
    end

    @win_condition = any_wins.include?(true)
  end

  def draw?
    @win_condition = true if board_state.uniq.size <= 2
  end

  def whos_turn?(player1, player2)
    @current_player = if current_player == player1
                        player2
                      elsif current_player == player2
                        player1
                      end
  end
end

def play(player1, player2, game)
  until game.win_condition
    game.current_player.make_selection(game)

    if game.game_over?
      puts "#{game.current_player.name} won! Congrats!"
    elsif game.draw?
      puts "It\'s a draw! Game Over."
    end

    game.current_player = game.whos_turn?(player1, player2)
  end
end

def setup_game
  player1 = Player.new
  puts "Hello, #{player1.name}! Your symbol is #{player1.symbol}."
  player2 = Player.new
  puts "Hello, #{player2.name}! Your symbol is #{player2.symbol}."
  game = Game.new(player1)

  play(player1, player2, game)
end

setup_game
