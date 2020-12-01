defmodule AdventOfCode.Repo do
  use Ecto.Repo,
    otp_app: :advent_of_code,
    adapter: Ecto.Adapters.Postgres
end
