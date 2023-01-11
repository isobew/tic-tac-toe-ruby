class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @options = ["0", "1"]
    @player2 = "X" 
    @player1 = "O" 
    @valid = true
    @multiplayer = nil
    @chosen = false
  end

  def start_game
    choose_multiplayer

    if @chosen == true
      show_board(@board)
      until game_is_over(@board) || tie(@board)
        get_player1_spot(@board)
        if !game_is_over(@board) && !tie(@board)
          if @multiplayer == false
            eval_board
          else
            show_board(@board)
            get_player2_spot(@board)
          end
        end
        show_board(@board)
      end
  
      if tie(@board)
        puts "Game over, tied."
      else
        winner(@board)
      end
    end
  end

  def choose_multiplayer()
    puts "Choose your game mode
    
    0 - User VS PC
    1 - User VS User
    "
    
    choice = nil

    until choice
      choice = gets.chomp

      until @options.include?(choice)
        puts "\nPLEASE, INSERT A VALID CHOICE\n"
        @valid = false
        return
      end

      choice = choice.to_i
      @valid = true
      @chosen = true
      if choice == 0
        @multiplayer = false
      else
        @multiplayer = true
      end
    end  
  end

  def show_board(board)
    puts "\n #{board[0]} | #{board[1]} | #{board[2]} \n===+===+===\n #{board[3]} | #{board[4]} | #{board[5]} \n===+===+===\n #{board[6]} | #{board[7]} | #{board[8]} \n"
    puts "\nInsert a number [0-8]:\n"
  end

  def get_player1_spot(board)
    available_spaces = []
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    
    spot = nil

    until spot
      spot = gets.chomp

      until available_spaces.include?(spot)
        puts "\nPLEASE, INSERT A VALID NUMBER\n"
        @valid = false
        return
      end

      spot = spot.to_i
      @valid == true
      if @board[spot] != "X" && @board[spot] != "O"
        @board[spot] = @player1
        @valid = true
      end
    end
  end

  def get_player2_spot(board)
    available_spaces = []
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    
    spot = nil

    until spot
      spot = gets.chomp

      until available_spaces.include?(spot)
        puts "\nPLEASE, INSERT A VALID NUMBER\n"
        @valid = false
        return
      end

      spot = spot.to_i
      @valid == true
      if @board[spot] != "X" && @board[spot] != "O"
        @board[spot] = @player2
        @valid = true
        show_board(@board)
      else
        spot = nil
      end
    end
  end

  def eval_board
    spot = nil

      until spot
        if @board[4] == "4" && @valid != false
          spot = 4
          @board[spot] = @player2
        else

          if @valid == false
            return
          else  
            spot = get_best_move(@board, @player2)
          end
          
          if @board[spot] != "X" && @board[spot] != "O"
            @board[spot] = @player2
          else
            spot = nil
          end
        end
      end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end

    available_spaces.each do |as|
      board[as.to_i] = @player2
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @player1
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end

    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def game_is_over(b)
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end

  def winner(board)
    b1 = [board[0], board[1], board[2]]
    b2 = [board[3], board[4], board[5]]
    b3 = [board[6], board[7], board[8]]
    b4 = [board[0], board[3], board[6]]
    b5 = [board[1], board[4], board[7]]
    b6 = [board[2], board[5], board[8]]
    b7 = [board[0], board[4], board[8]]
    b8 = [board[2], board[4], board[6]]

    if b1.uniq == ["X"] || b2.uniq == ["X"] || b3.uniq == ["X"] || b4.uniq == ["X"] || b5.uniq == ["X"] || b6.uniq == ["X"] || b7.uniq == ["X"] || b8.uniq == ["X"]
      puts "Game over, X is the winner"
    elsif b1.uniq == ["O"] || b2.uniq == ["O"] || b3.uniq == ["O"] || b4.uniq == ["O"] || b5.uniq == ["O"] || b6.uniq == ["O"] || b7.uniq == ["O"] || b8.uniq == ["O"]
      puts "Game over, O is the winner"  
    end 
  end
end

game = Game.new
game.start_game