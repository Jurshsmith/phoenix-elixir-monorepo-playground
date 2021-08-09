defmodule Menucard.Repo do
  use Ecto.Repo,
    otp_app: :menucard,
    adapter: Ecto.Adapters.Postgres
end
