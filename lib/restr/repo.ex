defmodule Restr.Repo do
  use Ecto.Repo,
    otp_app: :restr,
    adapter: Ecto.Adapters.Postgres
end
