defmodule Host do
  @name __MODULE__

  def greet(),     do: Agent.start_link(&HashDict.new/0, name: @name)
  def vote(actor), do: Agent.update(@name, fn(dict) -> Dict.update(dict, actor, 1, &(&1 + 1)) end)
  def votes(),     do: Agent.get_and_update(@name, fn(dict) -> {dict, HashDict.new} end)

  def announce() do
    [{first, first_votes}, {second, second_votes}] = tally_votes

    IO.puts "First looser: #{second} with #{second_votes} votes"
    IO.puts "Winner: #{first} with #{first_votes} votes"
  end

  def tally_votes() do
    votes
      |> Dict.to_list
      |> List.keysort(1)
      |> Enum.reverse
      |> Enum.take(2)
  end
end
