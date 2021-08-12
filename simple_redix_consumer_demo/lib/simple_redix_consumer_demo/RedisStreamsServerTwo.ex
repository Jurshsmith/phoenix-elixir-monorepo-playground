defmodule RedixStreamsServerTwo do
  use GenServer

  # Use Agent To Store state instead
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
    Agent.start_link(fn -> %{} end)
  end

  def init(_opts) do
    # Schedule a simple call to this process to trigger the handle_info concept
   schedule_call(2000, 0)

    {:ok, %{}}
  end

  # Use one function to read and give your state ?
  def handle_info({:check_stream, last_id: last_id}, state) do

    last_id
    |> IO.inspect()

    # Do stuff here
    task = Task.Supervisor.async_nolink(MyApp.TaskSupervisor, fn -> Redix.command!(:event_bus, ["XREAD", "COUNT", "1", "STREAMS", "mystream", last_id]) end)

    {:noreply, state}
  end

  # If the task succeeds...
  def handle_info({ref, result}, state) do
    # The task succeed so we can cancel the monitoring and discard the DOWN message
    Process.demonitor(ref, [:flush])

    if (!!result) do
      result
      |> IO.inspect

      last_id = result
      |> Enum.at(0)
      |> Enum.at(1)
      |> Enum.take(-1)
      |> Enum.at(0)
      |> Enum.at(0)



      state = Map.put(state, :last_id, last_id)
    end

    state
    |> IO.inspect()

    schedule_call(2000, state[:last_id])

    {:noreply, state}
  end

  # If the task fails...
  def handle_info({:DOWN, ref, _, _, reason}, state) do
    IO.puts "Redix Streams Check failed with reason #{inspect(reason)}"
    {:noreply, state}
  end


  defp schedule_call(delay \\ @polling_frequency, last_id), do: Process.send_after(self(), {:check_stream, last_id: last_id }, delay)
end
