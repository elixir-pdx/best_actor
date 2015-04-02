defmodule Show do
  def begin do
		actorList = ["Lauren Bacall", "Neil Patrick Harris", "Tom Hanks"]
    neil = spawn(Host, :greet, [Enum.count(actorList),[]])
    #send jimmy, {:choke, "2nd Elixir Games PDX Awards!"}
		spawn(Actor, :vote, [neil, actorList])
		spawn(Actor, :vote, [neil, actorList])
		spawn(Actor, :vote, [neil, actorList])
		spawn(Actor, :vote, [neil, actorList])
  end
end
