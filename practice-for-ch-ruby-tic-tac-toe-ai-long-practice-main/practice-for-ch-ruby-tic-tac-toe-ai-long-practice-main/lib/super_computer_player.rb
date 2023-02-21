require_relative 'tic_tac_toe_node'
require "byebug"
class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    #Buila TTTNode from the board stored in game.
    game_board = game.board
    node = TicTacToeNode.new(game_board,mark)

    childs = node.children
  
    winners = []
    ties = []
    childs.each do |child|
      if child.winning_node?(mark)
        winners << child.prev_move_pos
      end
    end
    # debugger
    return winners[0] if winners.length != 0
    childs.each  do |child|
      if child.losing_node?(mark) == false
        ties << child.prev_move_pos
      end
    end
    return  ties[0] if ties.length != 0
    raise "No non-losing moves" 
  end
end

if $PROGRAM_NAME == __FILE__
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end 
