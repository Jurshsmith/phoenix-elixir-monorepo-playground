defmodule PhxMonorepo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: PhxMonorepo.PubSub}
      # Start a worker by calling: PhxMonorepo.Worker.start_link(arg)
      # {PhxMonorepo.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: PhxMonorepo.Supervisor)
  end
end
