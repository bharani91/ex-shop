defmodule Ap.Repo do
  use Ecto.Repo, otp_app: :ap
  use Kerosene, per_page: 10
end
