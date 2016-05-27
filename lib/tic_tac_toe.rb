class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],  #top row win
    [3, 4, 5],  #middle row win
    [6, 7, 8],  #bottom row win
    [0, 3, 6],  #left column win
    [1, 4, 7],  #middle column win
    [2, 5, 8],  #right column win
    [0, 4, 8], #top left to bottom right win
    [2, 4, 6], #bottom left to top right win
  ]

  def move(position, player = "X")
    @board[position.to_i - 1] = player
  end

  def position_taken?(position)
    !(@board[position] == "" || @board[position] == " " || @board[position] == nil)
  end

  def valid_move?(position)
    position = (position.to_i - 1)

    if position.between?(0, 8) && !position_taken?(position)
      true
    else false
    end
  end

  def turn
    puts "Please enter 1-9:"
    position = gets.strip()
    valid = false
    while valid == false
      if valid_move?(position)
        move(position, current_player)
        display_board
        valid = true
      else
        puts "Invalid Move. Please enter 1-9:"
        position = gets.strip()
      end
    end
  end

  #--------begining of game status----------
  #checks for win combinations and prints winning combo, or nil
  def won?
    WIN_COMBINATIONS.each do |combo|
      if (@board[combo[0]] == @board[combo[1]] && @board[combo[0]] == @board[combo[2]] && @board[combo[0]] != " " && @board[combo[0]] != "" && !@board[combo[0]].nil?)
        return combo
        break
      end
    end
    return false
  end

  #returns true if every element of the board is full
  def full?
    if !(won?)
      @board.each do |e|
        if (e != "X" && e != "O")
          return false
        end
      end
    end
    return true
  end

  def draw?
    !(won?) && full?
  end

  def over?
    won? || draw?
  end

  def winner
    winner = won?
    if winner
      return @board[winner[0]]
    else
      nil
    end
  end
  #-------end of game status-----------

  #main application method responsible for game loop
  def play
    while !(over?)
      display_board
      turn
    end
      if won? != false
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "Cats Game!"
      end
  end

end
