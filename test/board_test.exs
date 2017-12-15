defmodule IslandsEngine.BoardTest do
  use ExUnit.Case

  test "valid guess" do
    expected = IslandsEngine.Board.new
    assert expected == %{}
  end
end
