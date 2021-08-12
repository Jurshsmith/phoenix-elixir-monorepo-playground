defmodule RedixStreamsServerTwo do
  use GenServer

  # Use Agent To Store state instead
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
    RedisStreamsAgent.start_link(nil)
  end

  def init(_opts) do
    # Schedule a simple call to this process to trigger the handle_info concept
    # RedisStreamsAgent.put(:last_id, 0)

    # RedisStreamsAgent.get(:last_id)
    # |> IO.inspect()
    schedule_call(2000)

    {:ok, %{}}
  end

  # Use one function to read and give your state ?
  def handle_info(:check_stream, state) do
    RedisStreamsAgent.get(:last_id)
    |> IO.inspect()

    # Do stuff here
    Task.Supervisor.async_nolink(MyApp.TaskSupervisor, fn ->
      Redix.command!(:event_bus, [
        "XREAD",
        "COUNT",
        "1",
        "STREAMS",
        "mystream",
        RedisStreamsAgent.get(:last_id)
      ])
    end)

    {:noreply, state}
  end

  # If the task succeeds...
  def handle_info({ref, result}, state) do
    # The task succeed so we can cancel the monitoring and discard the DOWN message
    Process.demonitor(ref, [:flush])

    if !!result do
      result
      |> IO.inspect()

      last_id =
        result
        |> Enum.at(0)
        |> Enum.at(1)
        |> Enum.take(-1)
        |> Enum.at(0)
        |> Enum.at(0)

      RedisStreamsAgent.put(:last_id, last_id)
    end

    RedisStreamsAgent.get(:last_id)
    |> IO.inspect()

    schedule_call(2000)

    {:noreply, state}
  end

  # If the task fails...
  def handle_info({:DOWN, ref, _, _, reason}, state) do
    IO.puts("Redix Streams Check failed with reason #{inspect(reason)}")
    {:noreply, state}
  end

  defp schedule_call(delay \\ @polling_frequency),
    do: Process.send_after(self(), :check_stream, delay)
end
