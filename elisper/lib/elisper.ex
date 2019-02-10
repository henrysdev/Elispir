defmodule Elisper do
  @moduledoc """
  Documentation for Elisper.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Elisper.hello()
      :world

  """
  def read(code) do
    tokens = code
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split()
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
    |> IO.puts()
    main
  end

end
