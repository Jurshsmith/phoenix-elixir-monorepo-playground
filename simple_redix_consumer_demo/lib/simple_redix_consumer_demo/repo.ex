defmodule SimpleRedixConsumerDemo.Repo do
  use Ecto.Repo,
    otp_app: :simple_redix_consumer_demo,
    adapter: Ecto.Adapters.Postgres
end
