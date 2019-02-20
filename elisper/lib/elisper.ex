defmodule Elisper do

  # import Stack

  @moduledoc """
  Documentation for Elisper.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Elisper.hello()
      :world

  """


  @doc false
  defp parse(["(" | t], accum) do
    {rest, expression} = parse(t, [])
    IO.inspect(sub_tree, label: "sub_tree")
    parse(rest, [expression | accum])
  end
  defp parse([")" | t], accum), do: {t, Enum.reverse(accum)}
  defp parse([], accum), do: Enum.reverse(accum)
  defp parse([h | t], accum), do: parse(t, [h | accum])
  #defp parse([h | t], accum), do: parse(t, [atom(h) | accum])


  def read(code) do
    code
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split()
    |> parse([])
  end

  def eval(expression) do
    expression
  end

  def main do
    code = IO.gets "> "
    code
    |> String.trim()
    |> read()
    |> eval()
    |> IO.inspect()
    main
  end

end
