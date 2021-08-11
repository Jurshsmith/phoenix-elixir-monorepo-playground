defmodule SimpleSupervisor do
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg)
  end

  @impl true
  def init(_init_arg) do
    children = [
      {DynamicSupervisor, name: SimpleDynamicSupervisor, strategy: :one_for_one}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

defmodule SimpleConsumer do
  use GenServer

  def start_supervised() do
    DynamicSupervisor.start_child(
      SimpleDynamicSupervisor,
      __MODULE__
    )
  end

  def start_link(_), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def init(_) do
    "Got here"
    |> IO.puts()

    handle_call(0)
    {:ok, :cool}
  end

  def handle_call(id) do

    task = Task.async(fn -> Redix.command!(:event_bus, ["XREAD", "COUNT", "5", "STREAMS", "mystream", id]) end)
    data = Task.await(task)

    "Got here again"
    |> IO.inspect

    id
    |> IO.puts

    all_data = data
    |> Enum.at(0)
    |> Enum.at(1)

    all_data
    |> IO.inspect

    # get last stream id
    id = all_data
    |> Enum.take(-1)
    |> Enum.at(0)
    |> Enum.at(0)

    id
    |> IO.inspect

    {:ok, :cool}
  end
end
