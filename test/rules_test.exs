defmodule IslandsEngine.RulesTest do
  use ExUnit.Case
  alias IslandsEngine.Rules

  test "valid coordinate" do
    expected = :players_set
    rules = Rules.new
    {:ok, rules} = Rules.check(rules, :add_player)
    assert expected == rules.state
  end
end
