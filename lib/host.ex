defmodule Host do
  def greet(totalVoters, tally) do 
    receive do
      {:choke, msg} -> 
        IO.puts("Derp! Derp! #{msg} I'm dying up here!")
			{:ballot, msg} ->
				IO.puts("Vote received for #{msg}!")
				tally = tally ++ [msg]
				count = Enum.count(tally)
				if count == totalVoters do
					result = Enum.group_by(tally, fn(x) -> x end)
					countedResult = Enum.map(result, fn {k,v} -> {k, Enum.count(v)} end)
					rankedResult = Enum.sort(countedResult, fn ({actor, votes},{actor2, votes2}) -> (votes > votes2) end)
					[winner|runnerUps] = rankedResult
					{winnerName, winnerVotes} = winner
					if Enum.count(runnerUps) > 0 do
						{runnerUpName, runnerUpVotes} = List.first(runnerUps)
						IO.puts("The runner up is #{runnerUpName} with #{runnerUpVotes} votes")
					end
					IO.puts("The winner is #{winnerName}! With #{winnerVotes} votes!")
				else
					greet(totalVoters, tally)
				end
    end
  end
end

# "Niel"
#
#   { "Neil": ["Neil", "Neil"]
