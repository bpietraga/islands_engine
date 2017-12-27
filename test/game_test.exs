defmodule IslandsEngine.GameTest do
  use ExUnit.Case

  alias IslandsEngine.{Game, Rules}

  test "win streak" do
    expected = {:hit, :dot, :win}
    {:ok, game} = Game.start_link("Miles")
    Game.add_player(game, "Trane")
    Game.position_island(game, :player1, :dot, 1, 1)
    Game.position_island(game, :player2, :square, 1, 1)
    state_data = :sys.get_state(game)
    :sys.replace_state(game, fn _data ->
      %{state_data | rules: %Rules{state: :player1_turn}}
    end)
    Game.guess_coordinate(game, :player1, 5, 5)
    assert expected == Game.guess_coordinate(game, :player2, 1, 1)
  end

  test "no win" do
    expected = {:miss, :none, :no_win}
    {:ok, game} = Game.start_link("Miles")
    Game.add_player(game, "Trane")
    Game.position_island(game, :player1, :dot, 1, 1)
    Game.position_island(game, :player2, :square, 1, 1)
    state_data = :sys.get_state(game)
    :sys.replace_state(game, fn _data ->
      %{state_data | rules: %Rules{state: :player1_turn}}
    end)
    assert expected == Game.guess_coordinate(game, :player1, 5, 5)
  end
end
