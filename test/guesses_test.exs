defmodule IslandsEngine.GuessesTest do
  use ExUnit.Case

  test "valid guess" do
    expected = IslandsEngine.Guesses.new
    assert expected == %IslandsEngine.Guesses{hits: MapSet.new, misses: MapSet.new}
  end

  test "Guesses are added to the MapSet" do
    expected = %IslandsEngine.Guesses{
      hits: MapSet.new(
        [
          %IslandsEngine.Coordinate{col: 3, row: 8},
          %IslandsEngine.Coordinate{col: 7, row: 9}
        ]
      ),
      misses: MapSet.new(
        [
          %IslandsEngine.Coordinate{col: 2, row: 1}
        ]
      )
    }
    guesses_init = IslandsEngine.Guesses.new()
    {:ok, coordinate1} = IslandsEngine.Coordinate.new(8, 3)
    guesses1 = IslandsEngine.Guesses.add(guesses_init, :hit, coordinate1)
    {:ok, coordinate2} = IslandsEngine.Coordinate.new(9, 7)
    guesses2 = IslandsEngine.Guesses.add(guesses1, :hit, coordinate2)
    {:ok, coordinate3} = IslandsEngine.Coordinate.new(1, 2)
    guesses2 = IslandsEngine.Guesses.add(guesses2, :miss, coordinate3)
    assert guesses2 == expected
  end
end
