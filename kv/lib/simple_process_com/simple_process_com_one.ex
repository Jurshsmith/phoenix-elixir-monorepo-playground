defmodule SimpleProcessCom.One do

  def init do
    "Simple Process Com.One Module Init Function ..."
    |> IO.puts

    initialize_sample_scenario_one()
  end

  defp initialize_sample_scenario_one do
    "Starting Scenario One ...."
    |> IO.puts

    # this scenario sends a message to the process before the receive hook was called
    # and this process (the parent) was still able to work with the previously sent messages
    # meaning that provided that process was alive when the message was sent, the receive hook can be called anytime in the future and would still be able process each of those messages
    create_new_simple_process_that_tells_current_process_hello()

    start_listening_for_messages_and_react_accordingly()
  end

  defp create_new_simple_process_that_tells_current_process_hello do
    # get the PID of this program's process and then
    parent_PID = self()


    # spawn a new process, at that point, self() refers to the process of the new spawned process,
    spawn(
      # this anonymous function is called immediately new process is created
      fn ->
        # Kernel.inspect converts anything to string.
        parent_PID_in_string = parent_PID
        |> Kernel.inspect

        # self here will be PID for the current spawned process
        current_spawned_process_PID = self()
        |> Kernel.inspect

        send(parent_PID, {:hello, "Hey, #{ parent_PID_in_string }, New Spawned Process You Birthed is #{current_spawned_process_PID}"})
      end
    )
  end

  defp start_listening_for_messages_and_react_accordingly do
    receive do
      {:hello, msg} ->
        msg
        |> IO.puts
      _ ->
        "Don't understand this process's message"
        |> IO.puts
    end
  end
end
