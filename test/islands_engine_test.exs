defmodule IslandsEngineTest do
  use ExUnit.Case
  doctest IslandsEngine

  alias IslandsEngine.{Coordinate, Guesses}

  test "new guesses" do
    guesses = Guesses.new
    {:ok, coordinate1} = Coordinate.new(1, 1)
    {:ok, coordinate2} = Coordinate.new(2, 2)
    guesses = update_in(guesses.hits, &MapSet.put(&1, coordinate1))
    guesses = update_in(guesses.hits, &MapSet.put(&1, coordinate2))
    guesses = update_in(guesses.hits, &MapSet.put(&1, coordinate1))

    assert guesses == %IslandsEngine.Guesses{
                        hits: MapSet.new([coordinate1,coordinate2]),
                        misses: MapSet.new
                      }
  end
end
