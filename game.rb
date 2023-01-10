class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X" 
    @hum = "O" 
    @valid = true
    @winner = nil
    @best_move = nil
  end

  def start_game
    show_board(@board)
    
    until game_is_over(@board) || tie(@board)
      get_human_spot(@board)
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
     
      show_board(@board)
    end

    if tie(@board)
      puts "Ninguém venceu"
    end
    # puts "Game over"
  end

  def show_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} \n===+===+===\n #{board[3]} | #{board[4]} | #{board[5]} \n===+===+===\n #{board[6]} | #{board[7]} | #{board[8]} \n"
    puts "Enter [0-8]:"
  end

  def get_human_spot(board)

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
        puts "Inclua um numero"
        @valid = false
        return
      end

      if available_spaces.include?(spot)
        spot = spot.to_i
        @valid == true
        if @board[spot] != "X" && @board[spot] != "O"
            @board[spot] = @hum
            @valid = true
        end
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
        @board[spot] = @com
      else
        if @valid == false
          return
        else  
          spot = get_best_move(@board, @com)
        end
          if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @com
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
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
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
      puts bets_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      m = available_spaces[n].to_i
      puts m
      puts "maquina acima"
      return m
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

end

game = Game.new
game.start_game
