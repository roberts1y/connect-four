class ConnectFourGame
  def initialize
    @board = Array.new(6) { Array.new(7, " ") }
    @current_player = "X"
  end

  def play
    loop do
      display_board

      puts "Player #{@current_player}, select a column to drop your piece (1-7):"
      column = gets.chomp.to_i - 1

      if valid_move?(column)
        drop_piece(column)
        if winner?
          display_board
          puts "Congratulations, Player #{@current_player} wins!"
          break
        elsif board_full?
          display_board
          puts "Game over, the board is full."
          break
        else
          switch_players
        end
      else
        puts "Invalid move. Please try again."
      end
    end
  end

  private

  def valid_move?(column)
    column.between?(0, 6) && @board[0][column] == " "
  end

  def drop_piece(column)
    row = 5
    row -= 1 while @board[row][column] != " " && row >= 0
    @board[row][column] = @current_player
  end

  def winner?
    # Check rows for winner
    @board.each do |row|
      (0..3).each do |i|
        return true if row[i..i+3].count(@current_player) == 4
      end
    end

    # Check columns for winner
    (0..6).each do |col|
      (0..2).each do |i|
        return true if @board[i][col] == @current_player && @board[i+1][col] == @current_player && @board[i+2][col] == @current_player && @board[i+3][col] == @current_player
      end
    end

    # Check diagonal (top left to bottom right) for winner
    (0..2).each do |row|
      (0..3).each do |col|
        return true if @board[row][col] == @current_player && @board[row+1][col+1] == @current_player && @board[row+2][col+2] == @current_player && @board[row+3][col+3] == @current_player
      end
    end

    # Check diagonal (bottom left to top right) for winner
    (3..5).each do |row|
      (0..3).each do |col|
        return true if @board[row][col] == @current_player && @board[row-1][col+1] == @current_player && @board[row-2][col+2] == @current_player && @board[row-3][col+3] == @current_player
      end
    end

    false
  end

  def board_full?
    @board[0].none? { |piece| piece == " " }
  end

  def switch_players
    @current_player = @current_player == "X" ? "O" : "X"
  end

  def display_board
    puts "\n 1 2 3 4 5 6 7"
    puts "---------------"
    @board.each do |row|
      row.each do |piece|
        print "|#{piece}"
      end
      puts "|"
      puts "---------------"
    end
    puts ""
  end
end

# Start the game
game = ConnectFourGame.new
game.play