defmodule RepoOneTest do
  use ExUnit.Case
  doctest RepoOne

  test "greets the world" do
    assert RepoOne.hello() == :world
  end
end
