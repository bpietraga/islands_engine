defmodule IslandsEngine.DemoProc do
  def loop do
    receive do
      msg -> IO.puts "I got #{msg}"
    end
    loop
  end
end
