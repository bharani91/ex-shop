defmodule Ap.Repo.Migrations.CreateProductCategory do
  use Ecto.Migration

  def change do
    create table(:product_categories) do
      add :title, :string
      add :slug, :string
      add :description, :text

      timestamps()
    end

    create unique_index(:product_categories, [:slug])

  end
end
