class TicTacToe
    attr_reader :board

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2],
    ]

    def display_board
       puts " #{board[0]} | #{board[1]} | #{board[2]} "
       puts "-----------"
       puts " #{board[3]} | #{board[4]} | #{board[5]} "
       puts "-----------"
       puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end
        
    def move(index, player)
        board[index] = player
    end
        
    def position_taken?(index)
        !board[index]&.strip&.empty?
    end
        
    def valid_move?(index)
        (0..8) === index && !position_taken?(index)
    end
        
    def turn
        puts "Please enter 1-9:"
        input = gets.strip
        index_position = input_to_index(input)
        if valid_move?(index_position)
            move(index_position, current_player)
            display_board
        else
            puts "Invalid move, try again!"
            puts "Position is taken or number is not between 1-9"
            turn
        end
    end
        
    def won?
        WIN_COMBINATIONS.find do |wc|
            win_index_1 = wc[0]
            win_index_2 = wc[1]
            win_index_3 = wc[2]
        
            position_1 = board[win_index_1]
            position_2 = board[win_index_2]
            position_3 = board[win_index_3]
                
        
            position_1 == position_2 && position_2 == position_3 && position_taken?( win_index_1)
        end
    end
        
    def full?
        board.all? { |i| i == "X" || i == "O"} 
    end
        
    def draw?
        !won? && full? 
    end
         
    def over?
        draw? || won?
    end
        
    def winner
        if wc = won?
            return board[wc[0]]
        end
    end
        
    def play
        turn until over? 
        puts won? ? "Congratulations #{winner}!" : "Cat's Game!"
    end
        
    def current_player
        turn_count % 2 == 0? "X" : "O"
    end
        
    def turn_count
        board.count { |space| space == "X" || space == "O"}    
    end
end