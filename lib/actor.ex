defmodule Actor do
  def bePretty do
    receive do
      {:vote, host, actors} ->
        send host, {:vote, hd(actors),
          hd(tl(actors))}
    end
  end
end
