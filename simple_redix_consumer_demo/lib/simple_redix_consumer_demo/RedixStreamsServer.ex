defmodule RedixStreamsServer do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(_opts) do
    # Schedule a simple call to this process to trigger the handle_info concept
    task = Task.Supervisor.async_nolink(MyApp.TaskSupervisor, fn -> Redix.command!(:event_bus, ["XREAD", "COUNT", "1", "STREAMS", "mystream", 0]) end)


    initial_state = Map.put(%{}, task.ref, 0)

    {:ok, initial_state}
  end

  # def handle_info(:check_stream, state) do
  #   IO.puts "Got here"

  #   state
  #   |> IO.inspect()

  #   task = Task.Supervisor.async_nolink(MyApp.TaskSupervisor, fn -> Redix.command!(:event_bus, ["XREAD", "COUNT", "1", "STREAMS", "mystream", state[:id]]) end)

  #   {:noreply, state}
  # end

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

      last_id
      |> IO.inspect()

      task = Task.Supervisor.async_nolink(MyApp.TaskSupervisor, fn -> Redix.command!(:event_bus, ["XREAD", "COUNT", "1", "STREAMS", "mystream", last_id]) end)

      state = Map.delete(state, ref)

      state = state |> Map.put(task.ref, last_id)
    end

    {:noreply, state}
  end

  # If the task fails...
  def handle_info({:DOWN, ref, _, _, reason}, state) do
    IO.puts "Redix Streams Check failed with reason #{inspect(reason)}"
    {:noreply, state}
  end


  defp schedule_call(delay \\ @polling_frequency), do: Process.send_after(self(), :check_stream, delay)
end
