class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X" # the computer's marker
    @hum = "O" # the user's marker
    @valid = true
    @winner = nil
    @best_move = nil
  end

  def start_game
    # start by printing the board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n===+===+===\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n===+===+===\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    puts "Enter [0-8]:"
    # loop through until the game was won or tied
    until game_is_over(@board) || tie(@board)
      get_human_spot(@board)
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n===+===+===\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n===+===+===\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    end
    if tie(@board)
      puts "Ninguém venceu"
    end
    puts "Game over"
  end

  def get_human_spot(board)

    available_spaces = []
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s.to_i

      end
    end
    puts "avail sp #{available_spaces}"

    
    spot = nil
    until spot

      # if available_spaces.include?(spot) == false
      #   puts "deu erro"
      #   @valid = false
      # end

      spot = gets.chomp.to_i
      # puts spot.class
      if available_spaces.include?(spot)
        @valid == true
        if @board[spot] != "X" && @board[spot] != "O"
          if spot >= @board.length
            puts "Insert a valid number"
            @valid = false
          else
            @board[spot] = @hum
            @valid = true
          end
        else
          puts "Insira em um campo disponível"
          @valid = false
          spot = nil
        end
      else
        puts "Tipo errado bro"
        @valid = false
        return
        # spot = nil
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
    # pesquisar o que é o |s|
    board.each do |s|
      if s != "X" && s != "O"
        # pesquisar oq é p <<
        # nao permitir escolher espaços já escolhidos
        available_spaces << s
      end
    end
    # print available_spaces
    available_spaces.each do |as|
      # puts as
      #atribuindo cada número available no @com
      board[as.to_i] = @com
      if game_is_over(board)
        # ainda nao entendi essa parte
        best_move = as.to_i
        board[as.to_i] = as
        # puts "best move comp #{best_move}"
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

    if 
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end

end

game = Game.new
game.start_game