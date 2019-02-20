defmodule State.Map do
  @moduledoc """
  State.Map is a module for persisting state in the form of a agent map.
  """

  def start_link do  
    Agent.start_link(fn -> %{
      "+" => &Enum.reduce(&1, 0, fn x, acc -> x + acc end)
    } end)  
  end

  def get(pid, key) do
    Agent.get(pid, &Map.get(&1, key))
  end  

  def put(pid, key, value) do  
    Agent.update(pid, &Map.put(&1, key, value))  
  end

end