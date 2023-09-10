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
end

def print_board(array_of_selections)
  puts "#{array_of_selections[0]} | #{array_of_selections[1]} | #{array_of_selections[2]}"
  puts '---------'
  puts "#{array_of_selections[3]} | #{array_of_selections[4]} | #{array_of_selections[5]}"
  puts '---------'
  puts "#{array_of_selections[6]} | #{array_of_selections[7]} | #{array_of_selections[8]}"
end

def game_over?(array_of_selections)
  if array_of_selections[0] == array_of_selections[1] && array_of_selections[1] == array_of_selections[2]
    true
  elsif array_of_selections[3] == array_of_selections[4] && array_of_selections[4] == array_of_selections[5]
    true
  elsif array_of_selections[6] == array_of_selections[7] && array_of_selections[7] == array_of_selections[8]
    true
  elsif array_of_selections[0] == array_of_selections[3] && array_of_selections[3] == array_of_selections[6]
    true
  elsif array_of_selections[1] == array_of_selections[4] && array_of_selections[4] == array_of_selections[7]
    true
  elsif array_of_selections[2] == array_of_selections[5] && array_of_selections[5] == array_of_selections[8]
    true
  elsif array_of_selections[0] == array_of_selections[4] && array_of_selections[4] == array_of_selections[8]
    true
  elsif array_of_selections[2] == array_of_selections[4] && array_of_selections[4] == array_of_selections[6]
    true
  else
    false
  end
end

def get_selection(current_player)
  puts "#{current_player.name}, make a selection: "
  gets.strip
end

def play_game
  player1 = Player.new
  puts "Hello, #{player1.name}! Your symbol is #{player1.symbol}."
  player2 = Player.new
  puts "Hello, #{player2.name}! Your symbol is #{player2.symbol}."

  board_state = %w[1 2 3 4 5 6 7 8 9]
  print_board(board_state)

  game_won = false
  current_player = player1
  until game_won
    selection = get_selection(current_player)
    board_state[selection.to_i - 1] = current_player.symbol
    print_board(board_state)
    game_won = game_over?(board_state)
    if !game_won && current_player == player1
      current_player = player2
    elsif !game_won && current_player == player2
      current_player = player1
    end
  end

  puts "#{current_player.name} won! Congrats!"
end

play_game
