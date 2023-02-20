require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos, :child_moves

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @child_moves = []
  end

  def losing_node?(evaluator)

    evaluator == :x ? opponent_mark = :o : opponent_mark = :x

    if @board.over? && @board.winner == opponent_mark
      return true
    elsif @board.over? && @board.winner != opponent_mark
      return false
    end

    all_lose = self.children.all? { |child| child.losing_node?(evaluator) }
    any_opp_win = @next_mover_mark == opponent_mark && self.children.any? { |child| child.losing_node?(evaluator) }
    all_lose || any_opp_win

  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves = []
    rec_board = @board.dup
    empty_pos = rec_board.open_positions.select { |pos| rec_board.empty?(pos) }
    empty_pos.each do |pos|
      current_board = @board.dup
      current_board[pos] = next_mover_mark
      next_mover_mark == :x ? opponent_mark = :o : opponent_mark = :x
      moves << TicTacToeNode.new(current_board, opponent_mark, pos) if !@board.over?
    end
    @child_moves = moves
  end
end
