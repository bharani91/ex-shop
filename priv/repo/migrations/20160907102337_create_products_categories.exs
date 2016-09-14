defmodule Ap.Repo.Migrations.CreateProductsCategories do
  use Ecto.Migration

  def change do
    create table(:products_categories) do
      add :product_id, references(:products)
      add :product_category_id, references(:product_categories)
    end
  end
end
