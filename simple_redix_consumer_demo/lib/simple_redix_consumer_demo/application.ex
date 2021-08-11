defmodule SimpleRedixConsumerDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # Start the Telemetry supervisor
      {Task.Supervisor, name: MyApp.TaskSupervisor},
      {RedixStreamsServer, name: :simple_async_genserver},
      SimpleRedixConsumerDemoWeb.Telemetry,
      # Start a worker by calling: SimpleRedixConsumerDemo.Worker.start_link(arg)
      # {SimpleRedixConsumerDemo.Worker, arg}
    ]

    Redix.start_link("redis://localhost:6378", name: :event_bus)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleRedixConsumerDemo.Supervisor]
    Supervisor.start_link(children, opts)

    # SimpleConsumer.start_supervised()
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SimpleRedixConsumerDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
