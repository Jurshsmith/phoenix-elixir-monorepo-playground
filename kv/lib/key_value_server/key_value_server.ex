defmodule KeyValue.Server do
  def start_link do
    # create a new process that listens to some commands to CRU the key value store
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map_state) do
    receive do
      {:get, key, caller_pid} ->
        # send response to caller pid
        send(caller_pid, Map.get(map_state, key))
        # use recursion to keep state
        loop(map_state)

      {:set, key, value} ->
        map_state
        |> Map.put(key, value)
        |> loop()
    end
  end
end
