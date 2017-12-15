defmodule IslandsEngine.CoordinateTest do
  use ExUnit.Case

  test "valid coordinate" do
    expected = IslandsEngine.Coordinate.new(1, 1)
    assert expected == {:ok, %IslandsEngine.Coordinate{col: 1, row: 1}}
  end

  test "invalid row with minus position" do
    expected = IslandsEngine.Coordinate.new(-1, 1)
    assert expected == {:error, :invalid_coordinate}
  end

  test "invalid row with too high position" do
    expected = IslandsEngine.Coordinate.new(11, 1)
    assert expected == {:error, :invalid_coordinate}
  end
end
