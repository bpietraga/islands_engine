defmodule IslandsEngine.RulesTest do
  use ExUnit.Case
  alias IslandsEngine.Rules

  test "initialzied state" do
    expected = :initialized
    rules = Rules.new()
    assert expected == rules.state
  end

  test "valid coordinate" do
    expected = :players_set
    rules = Rules.new
    {:ok, rules} = Rules.check(rules, :add_player)
    assert expected == rules.state
  end

  test "error for player positioning island multiple times" do
    expected = :error
    rules = Rules.new()
    rules = %{rules | state: :players_set}
    {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    assert expected == Rules.check(rules, {:position_islands, :player1})
  end

  test "player1_turn after both players setup islands" do
    expected = :player1_turn
    rules = Rules.new()
    rules = %{rules | state: :players_set}
    {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    {:ok, rules} = Rules.check(rules, {:position_islands, :player2})
    {:ok, rules} = Rules.check(rules, {:set_islands, :player2})
    assert expected == rules.state
  end

  test "player1_turn after both player1 guesses" do
    expected = :player2_turn
    rules = Rules.new()
    rules = %{rules | state: :players_set}
    {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    {:ok, rules} = Rules.check(rules, {:position_islands, :player2})
    {:ok, rules} = Rules.check(rules, {:set_islands, :player2})
    {:ok, rules} = Rules.check(rules, {:guess_coordinate, :player1})
    assert expected == rules.state
  end

  test "victory" do
    expected = :game_over
    rules = Rules.new()
    {:ok, rules} = Rules.check(rules, :add_player)
    {:ok, rules} = Rules.check(rules, {:position_islands, :player1})
    {:ok, rules} = Rules.check(rules, {:position_islands, :player2})
    {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    {:ok, rules} = Rules.check(rules, {:position_islands, :player2})
    {:ok, rules} = Rules.check(rules, {:set_islands, :player2})
    {:ok, rules} = Rules.check(rules, {:guess_coordinate, :player1})
    {:ok, rules} = Rules.check(rules, {:guess_coordinate, :player2})
    {:ok, rules} = Rules.check(rules, {:win_check, :win})
    assert expected == rules.state
  end

  test "no win" do
    expected = :player1_turn
    rules = Rules.new()
    {:ok, rules} = Rules.check(rules, :add_player)
    {:ok, rules} = Rules.check(rules, {:position_islands, :player1})
    {:ok, rules} = Rules.check(rules, {:position_islands, :player2})
    {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    {:ok, rules} = Rules.check(rules, {:position_islands, :player2})
    {:ok, rules} = Rules.check(rules, {:set_islands, :player2})
    {:ok, rules} = Rules.check(rules, {:guess_coordinate, :player1})
    {:ok, rules} = Rules.check(rules, {:guess_coordinate, :player2})
    {:ok, rules} = Rules.check(rules, {:win_check, :no_win})
    assert expected == rules.state
  end
end
