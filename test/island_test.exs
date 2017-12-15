defmodule IslandsEngine.IslandTest do
  use ExUnit.Case
  alias IslandsEngine.{Coordinate, Island}

  test "valid coordinate" do
    expected = Coordinate.new(4, 6)
    assert expected ==
    {:ok, %IslandsEngine.Coordinate{col: 6, row: 4}}
  end

  test "l shaped island with added coordinate" do
    {:ok, coordinate} = Coordinate.new(4, 6)
    expected = Island.new(:l_shape, coordinate)

    assert expected == {
      :ok,
      %IslandsEngine.Island{
        coordinates: MapSet.new(
          [
            %IslandsEngine.Coordinate{col: 6, row: 4},
            %IslandsEngine.Coordinate{col: 6, row: 5},
            %IslandsEngine.Coordinate{col: 6, row: 6},
            %IslandsEngine.Coordinate{col: 7, row: 6}
          ]
        ),
        hit_coordinates: MapSet.new
      }
    }
  end

  test "invalid coordinate" do
    {:ok, coordinate} = Coordinate.new(10, 10)
    assert Island.new(:l_shape, coordinate) == {:error, :invalid_coordinate}
  end

  test "invalid island type" do
    {:ok, coordinate} = Coordinate.new(4, 6)
    Island.new(:wrong, coordinate)
  end

  test "overlapping islands" do
    {:ok, square_coordinate} = Coordinate.new(1, 1)
    {:ok, square} = Island.new(:square, square_coordinate)

    {:ok, dot_coordinate} = Coordinate.new(1, 2)
    {:ok, dot} = Island.new(:dot, dot_coordinate)

    {:ok, l_shape_coordinate} = Coordinate.new(5, 5)
    {:ok, l_shape} = Island.new(:l_shape, l_shape_coordinate)

    assert true == Island.overlaps?(square, dot)
    assert false == Island.overlaps?(square, l_shape)
    assert false == Island.overlaps?(dot, l_shape)
  end
end
