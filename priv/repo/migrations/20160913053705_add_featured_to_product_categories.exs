defmodule Ap.Repo.Migrations.AddFeaturedToProductCategories do
  use Ecto.Migration

  def change do
    alter table(:product_categories) do
      add :featured, :boolean, default: true, null: false
    end

    create index(:product_categories, [:featured])
  end
end
