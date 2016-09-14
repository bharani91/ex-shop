defmodule Ap.Repo.Migrations.AddBasePriceToProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :base_price, :integer
    end
  end
end
