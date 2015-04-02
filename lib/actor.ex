defmodule Actor do
  def vote(x) do
    receive do
      {:ballot, tally, num_actors} -> 
        :random.seed(:erlang.now)
        send tally, {:filled_ballot, :random.uniform(num_actors)-1}
    end
  end
end
