defmodule AsyncGenServer do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(_opts) do
    # We will keep all running tasks in a map

    {:ok, %{tasks: %{}, id: 0 }}
  end


  # If the task succeeds...
  def handle_info({ref, result}, state) do
    IO.puts("Got here")
    # The task succeed so we can cancel the monitoring and discard the DOWN message
    Process.demonitor(ref, [:flush])

    {url, state} = pop_in(state.tasks[ref])
    IO.puts "Got #{inspect(result)} for URL #{inspect url}"
    {:noreply, state}
  end

  # If the task fails...
  def handle_info({:DOWN, ref, _, _, reason}, state) do
    {url, state} = pop_in(state.tasks[ref])
    IO.puts "URL #{inspect url} failed with reason #{inspect(reason)}"
    {:noreply, state}
  end

  defp schedule_api_call(delay \\ @polling_frequency), do: Process.send_after(self(), :do_api_call, delay)
end
