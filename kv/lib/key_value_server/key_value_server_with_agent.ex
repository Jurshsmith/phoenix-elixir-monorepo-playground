defmodule KeyValueServer.WithAgent do
  # Agent is a way simpler abstraction in managing states between processes
  #  set initial state when spawning new linked process with Agent.start_link api
  #  get and set the state with the concept of a callback function
  def start_link do
    Agent.start_link(fn -> %{} end)
  end

  def set(pid, key, value) do
    Agent.update(pid, fn map_state -> Map.put(map_state, key, value) end)
  end

  def get(pid, key) do
    Agent.get(pid, fn map_state -> Map.get(map_state, key) end)
  end
end
