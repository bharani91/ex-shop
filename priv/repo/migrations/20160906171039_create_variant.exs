defmodule Ap.Repo.Migrations.CreateVariant do
  use Ecto.Migration

  def change do
    create table(:variants) do
      add :title, :string
      add :description, :text
      add :price, :integer
      add :purchase_url, :string
      add :product_id, references(:products, on_delete: :delete_all)

      timestamps()
    end
    create index(:variants, [:product_id])

  end
end
