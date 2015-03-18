class Game

  attr_accessor :current_player

  def initialize
    reset_board
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    puts instructions
  end

  def new_game
    @current_player = [@player1, @player2].sample
    draw_board
    until false
      move(@current_player)
      if game_won
        restart('win')
      elsif draw
        restart('draw')
      end
      switch_player
    end
  end

  private

  def reset_board
    @board = [nil, '_', '_', '_', '_', '_', '_', '_', '_', '_']
  end

  def draw_board
    puts "_#{@board[1]}_|_#{@board[2]}_|_#{@board[3]}_"
    puts "_#{@board[4]}_|_#{@board[5]}_|_#{@board[6]}_"
    puts " #{@board[7]} | #{@board[8]} | #{@board[9]} "    
  end

  def instructions
    "Welcome to Tic Tac Toe! \n
    The goal is to place 3 X's or O's in a row, column, or diagonally.
    You can place your marks using the following acronyms:
      - 1 - upper left corner
      - 2 - upper middle field
      - 3 - upper right corner
      - 4 - middle left field
      - 5 - middle field
      - 6 - middle right field
      - 7 - bottom left corner
      - 8 - bottom middle field
      - 9 - bottom right corner\n"
  end

  def game_won
    wins = [
            [1,2,3], [4,5,6], [7,8,9],
            [1,4,7], [2,5,8], [3,6,9],
            [1,5,9], [7,5,3]
      ]

    status = false
    if wins.any? { |line| line.all? { |square| @board[square] == @current_player.sign}}
      status = true
    end
    status
  end

  def draw
    status = @board.none? { |square| square == '_' }
    status
  end

  def move(player)

    puts "#{player.name}, put #{player.sign} where?"
    player_input = gets.chomp.to_i

    if !player_input.between?(1, 10)
      puts "It doesn't seem to be a valid position. Try again."
      move(player)
    end

    if @board[player_input] == '_'
      @board[player_input] = "#{player.sign}"
      draw_board
    else
      puts "Invalid move! Try again."
      move(player)
    end
  end

  def switch_player
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def restart(reason)
    win_msg = "#{@current_player.name} won! You can be proud!\n"
    draw_msg = "Looke like a draw."

    case reason
      when 'win' then puts win_msg
      when 'draw' then puts draw_msg
    end

    puts "Play again? (y/n)"
    answer = gets.chomp.downcase
    if answer == 'y'
      reset_board
      new_game
    else
      exit
    end
  end

  class Player

    attr_accessor :name, :sign

    def initialize(name, sign)
      @name = name
      @sign = sign
    end
  end
end

p = Game.new
p.new_game

