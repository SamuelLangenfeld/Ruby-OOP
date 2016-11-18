
class Board


	def initialize
		@squares={}
		3.times do |i|
			3.times do |n|
				square_num="#{i+1}#{n+1}"
				@squares[square_num]=nil
			end
		end

		

	end


	def place_letter(piece_array)
		letter=piece_array[1]
		square_num=piece_array[0]
		
		
		target_square=@squares.assoc(square_num)
		if !target_square
			draw_grid
			puts "You did not choose a row or column number that exists. Try again."
			return false
		end
		
		
		if (target_square[1]!=nil)
			draw_grid
			puts "You chose a square that already has a letter in it. Try again."
			return false
		else
			@squares[square_num]=letter
			return true
		end



	end

	def draw_grid
		squares_array=@squares.to_a
		i=0
		row1="row 1  "
		3.times do
			if (squares_array[i][1]==nil)
				row1+="-"
			else 
				row1+= squares_array[i][1]
				
			end
			i+=1
		end

		row2="row 2  "
		3.times do
			if (squares_array[i][1]==nil)
				row2+="-"
			else 
				row2+= squares_array[i][1]
				
			end
			i+=1
		end

		row3="row 3  "
		3.times do
			if (squares_array[i][1]==nil)
				row3+="-"
			else 
				row3+= squares_array[i][1]
				
			end
			i+=1
		end

		puts "Current Game State"

		puts "column 123"


		puts row1
		puts row2
		puts row3


	end

	def check_for_win(marker)
		#check horizontal
		
		square_array=@squares.to_a
		
		test_squares=0
		i=0

		#check each row for 3 in a row

		3.times do
			3.times do
				if square_array[i][1]==marker
					test_squares+=1
				end
				i+=1				
			end
			if test_squares==3
				return 1
			else
				test_squares=0
			end
		end
		

		#check each column for 3 in a column
		i=0
		n=0

		#i=0, then 3, 6, then 1, then 4, then 7, then 2, then 5, then 8
		3.times do
			3.times do
				if square_array[i][1]==marker
					test_squares+=1
				end
				i+=3				
			end
			if test_squares==3
				return 1
			else
				test_squares=0
			end

			n+=1
			i=n
		end


		#check first diagonal
		i=0

		3.times do
			if square_array[i][1]==marker
				test_squares+=1
			end
			i+=4				
		end
		if test_squares==3
			return 1
		else
			test_squares=0
		end

		#check second diagonal
		i=2
		3.times do
			if square_array[i][1]==marker
				test_squares+=1
			end
			i+=2				
		end
		if test_squares==3
			return 1
		else
			test_squares=0
		end

		#check for draw
		empty_squares=square_array.size
		i=0
		square_array.each do |n|
			if n[1]!=nil
				empty_squares-=1
			end
		end


		if empty_squares==0
			return 2
		end
		return 0
	end






end

class Person

	def initialize(num)
		@number=num

		if @number==1
			@letter="x"
		else
			@letter="o"
		end
	end

	def choose_square(square_num)
		return [square_num,@letter]
	end

	def to_s
		return "Player #{@number}"
	end

	def get_marker
		return @letter
	end

end


class Game

	def initialize
		@game_board=Board.new
		@player1=Person.new(1)
		@player2=Person.new(2)
		@current_player=@player1
		@game_board.draw_grid
		new_turn(@player1)
	end

	private

	def new_turn(player)

		test=false
		while !test do
			puts "It is #{player}'s turn"
			puts "Enter the row you wish to place your letter in"
			row=gets.chomp
			puts "Enter the column you wish to place your letter in"
			column=gets.chomp
			square_num=row+column
			
			
			test=@game_board.place_letter(player.choose_square(square_num))
		end

		@game_board.draw_grid

		#ongoing is 0
		#win is 1
		#draw is 2


		victory_condition=@game_board.check_for_win(@current_player.get_marker)


		if victory_condition==1
		  puts "You win! Congratulations, #{@current_player}!"
		  puts "Press the enter key to play again!"
		  new_variable=gets
		  return


		  
		elsif victory_condition==2
		  puts "Game Over! It's a draw!"
		  puts "Press the enter key to play again!"
		  new_variable=gets
		  return
		  
		end



		if victory_condition==0

			if @current_player==@player1
				@current_player=@player2
			else
				@current_player=@player1
			end

			new_turn(@current_player)
		end

		
		return


	end



end

