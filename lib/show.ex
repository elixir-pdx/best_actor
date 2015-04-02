defmodule Show do
  def begin do
    jimmy = spawn(Host, :greet, [])
    actors = [:bob, :sally, :joe, :larry, :emily]
    send jimmy, {:tally, [actors]}
    send jimmy, {:choke, "2nd Elixir Games PDX Awards!"}
  end
end