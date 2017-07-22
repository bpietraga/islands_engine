defmodule IslandsEngine.GuessesTest do
  use ExUnit.Case

  test "valid guess" do
    expected = IslandsEngine.Guesses.new
    assert expected  == %IslandsEngine.Guesses{hits: MapSet.new, misses: MapSet.new}
  end
end
