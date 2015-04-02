
defmodule Host do

  def greet do
    receive do
      {:choke, msg} ->
        IO.puts("Derp! Derp! #{msg} I'm dying up here!")
      {:shine, numGuests, msg} ->
        IO.puts("Good evening folks and welcome to the #{msg}")
        tally(numGuests,[],[])
    end
  end

  def tally(numGuests, firsts, runnersUp) do
    IO.puts("Tallying...")
    receive do
      {:vote, first, runnerUp} ->
        IO.puts("Got vote!")
        cond do
          numGuests == 1 ->
            reportWinners(firsts,runnersUp)
          true ->
            tally(numGuests - 1, [first] ++ firsts, [runnerUp] ++ runnersUp)
        end
    end
  end

  def reportWinners(firsts,runnersUp) do
    {winner, runnerUp} = {getMostFrequent(firsts), getMostFrequent(runnersUp)}
    IO.puts("And the runner up is... #{inspect(runnerUp)}")
    IO.puts("And the winner is... #{inspect(winner)}")
  end

  def getMostFrequent(list) do
    getMostFrequentHelper(list,HashDict.new())
  end

  def getMostFrequentHelper(list, dict) do
    cond do
      list == [] ->
       {winner,_} = Enum.reduce(Dict.to_list(dict),
          fn({key,val},{bestKey, bestVal}) ->
            # first there wins.
            if(val > bestVal) do
             {key, val}
            else
             {bestKey, bestVal}
            end
          end
          ) #reduce
          winner


      [head|tail] = list ->
        cond do
          Dict.has_key?(dict, head) == true ->
            getMostFrequentHelper(tail,
            Dict.put(dict, head, Dict.get(dict, head) + 1))
          true ->
            getMostFrequentHelper(tail,
            Dict.put(dict, head, 1))
        end
    end
  end
end
