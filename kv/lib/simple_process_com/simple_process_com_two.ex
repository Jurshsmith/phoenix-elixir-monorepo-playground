defmodule SimpleProcessCom.Two do
  # NOT PROVEN YET
  def init do
    "Simple Process Com Two Module Init Function ..."
    |> IO.puts()

    initialize_error_scenario_with_spawn()
    initialize_error_scenario_with_spawn_link()
  end

  defp initialize_error_scenario_with_spawn do
    # Since processes are isolated, this will not affect parent process
    spawn(fn -> raise "oops" end)

    # or use Task for better error reporting
    Task.start(fn -> raise "oops" end)
  end

  defp initialize_error_scenario_with_spawn_link do
    # With spawn_link, it will affect the parent component,
    # Use case: Fault tolerance, supervisors to be alerted when a child process fails, so that the supervisor restarts those processes
    spawn_link(fn -> raise "oops" end)

    # or use Task for better error reporting
    Task.start_link(fn -> raise "oops" end)
  end
end
