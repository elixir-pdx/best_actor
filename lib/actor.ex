defmodule Actor do
	def vote(host, actorList) do
		:random.seed(:erlang.now)
		choice = Enum.at(actorList, :random.uniform(Enum.count(actorList)) - 1)
		#choice = "Rigged vote"
		send host, {:ballot, choice}
	end
end
