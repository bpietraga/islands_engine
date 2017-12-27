defmodule IslandsEngine.GameSupervisorTest do
  use ExUnit.Case

  alias IslandsEngine.{Game, GameSupervisor}

  test "resets pid" do
#     expected = {:hit, :dot, :win}
    {:ok, game} = GameSupervisor.start_game("Hopper")
    via         = Game.via_tuple("Hopper")
    first_pid   = GenServer.whereis(via)
    Game.add_player(via, "Hockney")
    state_data = :sys.get_state(via)
    state_data.player1.name
    state_data.player2.name
    Process.exit(game, :kaboom)
    second_pid = GenServer.whereis(via)
    assert first_pid != second_pid
  end
end
