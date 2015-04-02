defmodule Host do
  def greet do 
    receive do
      {:choke, msg} -> 
        IO.puts("Derp! Derp! #{msg} I'm dying up here!")
      {:shine, msg} -> 
        IO.puts("Good evening folks and welcome to the #{msg}")
        greet()
      {:runnerup, msg} ->
      	IO.puts("And the runner up is.... #{msg}")
        greet()
      {:winner, msg} ->
        IO.puts("The Winner, by self voting and cheating, is #{msg}. Pass out the cocaine.")
    end
  end
end
