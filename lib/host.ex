defmodule Host do
  require IEx
  def greet do 
    receive do
      {:tally, [actors]} ->
      	tally(actors)
      {:choke, msg} -> 
        IO.puts("Derp! Derp! #{msg} I'm dying up here!")
      {:shine, msg} -> 
        IO.puts("Good evening folks and welcome to the #{msg}")
        greet()
    end
  end

  def tally(actors) do
  	  pids = actors |> Enum.map (fn(name) ->
    		spawn(Actor, :vote, [actors, self])
    	end)

       votes = pids |> Enum.map(fn(pid) -> 
        	receive do {:vote, ^pid, actor} -> actor end
        end)

       IO.inspect("voted for: #{inspect votes}")
  end
end
