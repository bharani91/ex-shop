defmodule Ap.Repo.Migrations.CreatePage do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :title, :string
      add :page_title, :string
      add :content, :text
      add :slug, :string

      timestamps()
    end

    create unique_index(:pages, [:slug])

  end
end
