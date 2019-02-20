defmodule State.Map do
  @moduledoc """
  State.Map is a module for persisting state in the form of a agent map.
  """

  def start_link do  
    Agent.start_link(fn -> %{
      "+" => &Enum.reduce(&1, fn x, acc -> acc + x end),
      "-" => &Enum.reduce(&1, fn x, acc -> acc - x end),
      "*" => &Enum.reduce(&1, fn x, acc -> acc * x end),
      "/" => &Enum.reduce(&1, fn x, acc -> acc / x end),
    } end)  
  end

  def get(pid, key) do
    IO.inspect(key, label: "key")
    Agent.get(pid, &Map.get(&1, key))
  end  

  def put(pid, key, value) do  
    Agent.update(pid, &Map.put(&1, key, value))  
  end

end