defmodule Actor do
	def vote(names, tally) do
		send tally, {:voting, ballot(names)}
	end

	def ballot(names) do
		:random.seed(:erlang.now)
		names
		|> Enum.shuffle
		|> hd
	end
end
