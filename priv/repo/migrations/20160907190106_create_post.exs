defmodule Ap.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :slug, :string
      add :page_title, :string
      add :meta_description, :text
      add :content, :text
      add :published, :boolean, default: false, null: false
      add :published_at, :datetime
      add :featured_image, :string

      timestamps()
    end

    create unique_index(:posts, [:slug])
    create index(:posts, [:published_at])
    create index(:posts, [:published])

  end
end
