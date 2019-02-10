defmodule ElisperTest do
  use ExUnit.Case
  doctest Elisper

  test "greets the world" do
    assert Elisper.hello() == :world
  end
end
