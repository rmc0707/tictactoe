class TicTacToe

	def initialize
		puts "\n\n\n\n\n\n\n\n\n\n\n\n\n
			************ Welcome to Tic-Tac-Toe! ************
			\n\n\n\n\n\n\n"
	end

	#Main method for playing a game.
	def play
		newgame
		new_board
		turns
	end

	#Continues the game until someone wins.
	def turns
		while winner?(@gameboard.board) == false || tie_game?(@gameboard.board) == false
			puts "\n\n\n\n\n\n\nIt is now #{@current_player.name}'s turn."
			puts @gameboard.draw_board
			@gameboard.update_board(@current_player.side)
			switch_player
		end	
		if winner?(@gameboard.board) == true
			switch_player
			puts @gameboard.draw_board
			puts "\n\n\n\n********* Congratulations! #{@current_player.name} wins! *********\n\n\n\n\n\n"
		else
			puts @gameboard.draw_board
			puts "Tie Game!"
		end
	end

	#Switches the active player
	def switch_player
		@current_player = (@current_player == @player1 ? @player2 : @player1)
	end

	def all_equal?(array) array.max == array.min end

	#Method that reads the current game board to see if there is a winner.
	def winner?(array)
		diagonal = @gameboard.diagonals
		column = @gameboard.columns
		3.times do |i|
		 	if all_equal?(array[i]) == true && array[i].any? {|x| x == "{ }"} == false
				return true
			elsif all_equal?(diagonal[0]) == true && diagonal[0].any? { |x| x == "{ }"} == false
				return true
			elsif all_equal?(diagonal[1]) == true && diagonal[1].any? { |x| x == "{ }"} == false
				return true
			elsif all_equal?(column[i]) == true && column[i].any? { |x| x == "{ }"} == false
				return true
			end
		end
		false
	end

	#Method that reads the current game board to see if there is a tie game.
	def tie_game?(array)
		3.times do |i|
			if array[i].none? { |x| x == "{ }"} == true
				return true
			end
		end
	end


	class Player
		attr_accessor :side, :name
		def initialize(name = "Player", side = "X")
			@name = name
			@side = side
		end
	end

	class Cell
		attr_accessor :value
		def initialize(value = "{ }")
			@value = value
		end
	end

	class Board
		attr_reader :grid
		attr_accessor :board
		attr_accessor :map_point
				
		def initialize
			@board = Array.new(3){ Array.new(3) {Cell.new.value}}
		end

		def draw_board
			print "\n\n"
			3.times do |y|
				3.times do |x|
					print "--" + "#{@board[y][x]}" + "--"
				end
				print "\n\n\n\n"
			end
			print "\n\n"
		end

		def update_board(value)
			@value = value
			i = 0
			puts "\n    1   2   3\n\n    4   5   6\n\n    7   8   9\n"
			while i < 1
				puts "\nWhere would you like to put your #{value}?"
				
				location = Integer(gets) rescue 0
				if location <10 && location > 0
					location = location.to_s
					if @board[board_location(location)[0]][board_location(location)[1]] == "{ }"
						@board[board_location(location)[0]][board_location(location)[1]] = "{#{value}}"
						i += 1
					else
						puts "\nThat square is taken already."
					end
				else
					puts "Please enter a valid number 1-9"
				end
			end
		end

		def board_location(human_move)
			map_point = {"1" => [0, 0], "2" => [0, 1], "3" => [0, 2],
						 "4" => [1, 0], "5" => [1, 1], "6" => [1, 2],
						 "7" => [2, 0], "8" => [2, 1], "9" => [2, 2]}
			return map_point[human_move]
		end

		def diagonals
			[
				[board[0][0], board[1][1], board[2][2]],
				[board[2][0], board[1][1], board[0][2]]
			]	
		end

		def columns
			[
				[board[0][0], board[1][0], board[2][0]],
				[board[0][1], board[1][1], board[2][1]],
				[board[0][2], board[1][2], board[2][2]]
			]	
		end
	end

	def new_board
		@gameboard = Board.new
	end

	#This method gathers names and tokens for each player, and will prevent both players from having the same side.
	def newgame
		i = 0
		while i < 1 do
			@player1 = Player.new()
			@player2 = Player.new()
			puts "\nPlayer 1, please tell us your name\n"
			@player1.name = gets.chomp
			puts "\nWhat side?\n"
			@player1.side = gets.chomp
			puts "\nPlayer 2, please tell us your name\n"
			@player2.name = gets.chomp
			puts "\nWhat side?\n"
			@player2.side = gets.chomp
			if @player2.side != @player1.side
				puts "\n\nWelcome, #{@player1.name} and #{@player2.name}!"
				@current_player = @player1
				i += 1
			else
				puts "Can't have the same side!"
			end
		end
	end

end



game = TicTacToe.new
game.play
