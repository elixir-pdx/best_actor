defmodule Show do
  def begin do
    jimmy = spawn(Host, :greet, [])
    send jimmy, {:choke, "2nd Elixir Games PDX Awards!"}

    
    actor1 = spawn(Actor, :vote, [0])
    actor2 = spawn(Actor, :vote, [1])
    actor3 = spawn(Actor, :vote, [2])
    tally = spawn(Show, :tally, [{0,0,0}])
    #all_actors = [actor1, actor2, actor3]
    send actor1, {:ballot, tally, 3}
    send actor2, {:ballot, tally, 3}
    send actor3, {:ballot, tally, 3}
 
  end

  def tally(votes) do
    receive do
      {:filled_ballot, 0} -> 
        result = {elem(votes, 0)+1, elem(votes, 1), elem(votes, 2)}
        IO.puts(inspect(result))
        tally(result)
      {:filled_ballot, 1} -> 
        result = {elem(votes, 0), elem(votes, 1)+1, elem(votes, 2)}
        IO.puts(inspect(result)) 
        tally(result)
      {:filled_ballot, 2} -> 
        result = {elem(votes, 0), elem(votes, 1), elem(votes, 2)+1}
        IO.puts(inspect(result)) 
        tally(result)
    end
  end
end
