defmodule Cams.Repo do
  use Ecto.Repo,
    otp_app: :cams,
    adapter: Ecto.Adapters.Postgres
end
