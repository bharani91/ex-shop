defmodule Ap.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :slug, :string
      add :page_title, :string
      add :content, :text
      add :vendor, :string
      add :demo_url, :string
      add :meta_description, :text
      add :extract, :text

      timestamps()
    end

    create unique_index(:products, [:slug])
    create unique_index(:products, [:title])

  end
end
