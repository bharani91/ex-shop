defmodule Ap.Repo.Migrations.CreateProductImage do
  use Ecto.Migration

  def change do
    create table(:product_image) do
      add :public_id, :string
      add :url, :string
      add :secure_url, :string
      add :product_id, references(:products, on_delete: :delete_all)

      timestamps()
    end
    create index(:product_image, [:product_id])

  end
end
