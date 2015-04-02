defmodule Actor do
	def vote(actors, host) do
		IO.puts("voting")
		:random.seed(:erlang.now())
		count = Enum.count(actors) - 1
		actor = Enum.at(actors, :random.uniform(count))
		send host, {:vote, self, actor}
	end

end
