require 'tic-tac-toe'

=begin

First thoughts: to win the game an instance of Board must check its array for the right combos
In my code I did this with a couple of algorithms for checking columns, then rows, then diagonals

I could just load up an array of arrays, or a hash and check those.

Then load up some arrays that don't make wins and then see if I get a false.



=end
describe Board do 

	describe ".check_for_win" do

		let(:no_win) do
			new_Board=Board.new
		end

		let(:x_win_row) do
			x_win_board=Board.new
			x_win_board.instance_variable_set(:@squares, {"11"=>'x', '12'=>'x', '13'=>'x', '21'=>nil, '22'=>nil, '23'=>nil, '31'=>nil, '32'=>nil,'33'=>nil})
			return x_win_board
		end

		let(:x_win_column) do
			x_win_board=Board.new
			x_win_board.instance_variable_set(:@squares, {"11"=>'x', '12'=>nil, '13'=>nil, '21'=>'x', '22'=>nil, '23'=>nil, '31'=>'x', '32'=>nil,'33'=>nil})
			return x_win_board
		end

		let(:x_win_left_diagonal) do
			x_win_board=Board.new
			x_win_board.instance_variable_set(:@squares, {"11"=>'x', '12'=>nil, '13'=>nil, '21'=>nil, '22'=>'x', '23'=>nil, '31'=>nil, '32'=>nil,'33'=>'x'})
			return x_win_board
		end

		let(:x_win_right_diagonal) do
			x_win_board=Board.new
			x_win_board.instance_variable_set(:@squares, {"11"=>nil, '12'=>nil, '13'=>'x', '21'=>nil, '22'=>'x', '23'=>nil, '31'=>'x', '32'=>nil,'33'=>nil})
			return x_win_board
		end

		let(:o_win_row) do
			o_win_board=Board.new
			o_win_board.instance_variable_set(:@squares, {"11"=>'o', '12'=>'o', '13'=>'o', '21'=>nil, '22'=>nil, '23'=>nil, '31'=>nil, '32'=>nil,'33'=>nil})
			return o_win_board
		end

		let(:draw) do
			draw_board=Board.new
			draw_board.instance_variable_set(:@squares, {"11"=>'x', '12'=>'o', '13'=>'x', '21'=>'x', '22'=>'x', '23'=>'o', '31'=>'o', '32'=>'x','33'=>'o'})
			return draw_board
		end

		context "if there's no winner and still spaces available" do
			it "returns 0 for draw" do
				expect(no_win.check_for_win("x")).to eql(0)
			end
		end

		context "if there's three in a row" do
			it "returns 1 for the winner" do
				expect(x_win_row.check_for_win("x")).to eql(1)
			end
		end

		context "if o, or Player 2, has winning combo" do
			it "returns 1 for o win" do
				expect(o_win_row.check_for_win("o")).to eql(1)
			end
		end

		context "if a player has a column filled in" do
			it "returns 1 for the winner" do
				expect(x_win_column.check_for_win('x')).to eql(1)
			end
		end

		context "if a player has the diagonal starting from top left filled in" do
			it "returns 1 for the winner" do
				expect(x_win_left_diagonal.check_for_win('x')).to eql(1)
			end
		end

		context "if a player has the diagonal starting from top right filled in" do
			it "returns 1 for the winner" do
				expect(x_win_right_diagonal.check_for_win('x')).to eql(1)
			end
		end

		context "if no more open spaces, and no winner" do
			it "returns 2 for a draw" do
				expect(draw.check_for_win("o")).to eql(2)
			end
		end
	
	end

	describe ".place_letter" do
		let(:x_board) do
			x_board=Board.new
			x_board.instance_variable_set(:@squares, {"11"=>'x', '12'=>nil, '13'=>nil, '21'=>nil, '22'=>nil, '23'=>nil, '31'=>nil, '32'=>nil,'33'=>nil})
			return x_board
		end

		let(:place_on_11) do
			array=["11", "x"]
		end
		let(:place_on_12) do
			array=["12", "x"]
		end

		let(:place_on_40) do
			array=["40", "x"]
		end


		context "if you attempt to place a letter on an occupied space" do
			it "returns false" do
				expect(x_board.place_letter(place_on_11)).to eql(false)
			end
		end

		context "if you attempt to place a letter on an unoccupied space" do
			it "returns true" do
				expect(x_board.place_letter(place_on_12)).to eql(true)
			end
		end

		context "if you attempt to place a letter on an invalid square" do
			it "returns false" do
				expect(x_board.place_letter(place_on_40)).to eql(false)
			end
		end				
	end

end