defmodule KV do
  @moduledoc """
  Documentation for `KV`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> KV.hello()
      :world

  """

  # The function mix tries to start based on the 'application' registry in the mix.exs
  # Fun fact: mix.exs is a script file that can be run on your OS level programmatically ?
  # On execution of this function, mix wants to get a tuple of {:ok , PID } so return self() for this simple use case

  def start(_type, _args) do
    "Started KV..."
    |> IO.puts()

    # SimpleProcessCom.One.init()

    # SimpleProcessCom.Two.init()

    # KeyValue.Server.start_link()

    Redix.start_link("redis://localhost:6378", name: :event_bus)

    GenServer.start_link(StackGenServer, [:hello]);

    pid = self()
    {:ok, pid}
  end

  def hello do
    :world
  end
end
