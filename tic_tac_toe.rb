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
      raise StandardError if selection.negative? || selection > 9
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
  end

  def game_over?
    @win_condition = if board_state[0] == board_state[1] && board_state[1] == board_state[2]
                       true
                     elsif board_state[3] == board_state[4] && board_state[4] == board_state[5]
                       true
                     elsif board_state[6] == board_state[7] && board_state[7] == board_state[8]
                       true
                     elsif board_state[0] == board_state[3] && board_state[3] == board_state[6]
                       true
                     elsif board_state[1] == board_state[4] && board_state[4] == board_state[7]
                       true
                     elsif board_state[2] == board_state[5] && board_state[5] == board_state[8]
                       true
                     elsif board_state[0] == board_state[4] && board_state[4] == board_state[8]
                       true
                     elsif board_state[2] == board_state[4] && board_state[4] == board_state[6]
                       true
                     else
                       false
                     end
  end
end

def play(player1, player2, game)
  until game.win_condition
    game.current_player.make_selection(game)

    puts "#{game.current_player.name} won! Congrats!" if game.game_over?

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
