defmodule Show do
  def begin do
    numActors = 42

    actors = for n <- 1..numActors, do: spawn(Actor, :bePretty, [])

    jimmy = spawn(Host, :greet, [])
    send jimmy, {:shine, numActors, "2nd Elixir Games PDX Awards!"}

    #send hd(actors), {:vote, jimmy, actors}

    Enum.map(actors, fn (a) -> send a, {:vote, jimmy, actors} end)
  end
end
