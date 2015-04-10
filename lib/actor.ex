defmodule Actor do
  def vote(_actor, nominees) do
    pick = random(Enum.count(nominees) - 1)

    nominees
      |> Enum.at(pick)
      |> Host.vote
  end

  def random(n) do
    << a :: 32, b :: 32, c :: 32 >> = :crypto.rand_bytes(12)
    :random.seed(a, b, c)
    :random.uniform(n)
  end
end
