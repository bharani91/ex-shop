defmodule Ap.Repo.Migrations.AddFeaturedToProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :featured, :boolean, default: true, null: false
    end

    create index(:products, [:featured])
  end
end
