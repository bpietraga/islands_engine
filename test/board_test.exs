defmodule IslandsEngine.BoardTest do
  use ExUnit.Case

  alias IslandsEngine.{Board, Coordinate, Island}

  test "valid guess" do
    expected = IslandsEngine.Board.new
    assert expected == %{}
  end

  test "overlapping islands" do
    expected = {:error, :overlapping_island}
    board = Board.new()
    {:ok, square_coordinate} = Coordinate.new(1, 1)
    {:ok, square} = Island.new(:square, square_coordinate)
    board = Board.position_island(board, :square, square)

    {:ok, dot_coordinate} = Coordinate.new(2, 2)
    {:ok, dot} = Island.new(:dot, dot_coordinate)

    assert expected == Board.position_island(board, :dot, dot)
  end

  test "not overlapping islands" do
    expected = %{
      dot: %IslandsEngine.Island{
        coordinates: MapSet.new([%IslandsEngine.Coordinate{col: 3, row: 3}]),
        hit_coordinates: MapSet.new([])
      }
    }
    board = Board.new()
    {:ok, dot_coordinate} = Coordinate.new(2, 2)
    {:ok, dot} = Island.new(:dot, dot_coordinate)
    {:ok, new_dot_coordinate} = Coordinate.new(3, 3)
    {:ok, dot} = Island.new(:dot, new_dot_coordinate)

    board = Board.position_island(board, :dot, dot)

    assert expected == board
  end
end
