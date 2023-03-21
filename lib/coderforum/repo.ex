defmodule Coderforum.Repo do
  use Ecto.Repo,
    otp_app: :coderforum,
    adapter: Ecto.Adapters.Postgres
end
