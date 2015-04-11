defmodule Show do
  def begin() do
    Host.greet

    actors = [:jimmy, :brad, :sam, :joan, :ron, :sally, :liz,
              :zoe, :lynne, :ruby, :jacob, :briggs, :buster]

    actors
      |> Enum.map(&Task.async(fn -> Actor.vote(&1, actors) end))
      |> Enum.map(&Task.await(&1))

    Host.announce
  end
end
