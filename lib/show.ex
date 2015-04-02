defmodule Show do
  def begin(number_actors) do
    jimmy = spawn(Host, :greet, [])
    send jimmy, {:shine, "the Elixir totally fair rigged actor games!"}
    
    #generate names
    names = names(number_actors)
    
    #spawn actors from names
    for name <- 1..number_actors do
	    #ask actors to vote
    	spawn(Actor, :vote, [names, self])
    end

    #tally results
    results = tally(number_actors, []) 

    #sort our results
    dict = Enum.group_by(results, fn(n) -> n end)
    tuples = Dict.to_list(dict)
    [{winner, _}, {runnerup, _}|rest] = Enum.sort_by(tuples, fn({n, v}) -> length(v) end) |> Enum.reverse

    send jimmy, {:runnerup, runnerup}
    send jimmy, {:winner, winner}
  end


  def names(number_actors) do
  	for current_number <- 1..number_actors, into: [] do
  		"name #{current_number}"
  	end
  end

  def tally(0, votes) do
  	votes
  end

  def tally(votes_left, votes) do
  	receive do
  		{:voting, name} -> tally(votes_left - 1, [name|votes])
  	end
  end

end