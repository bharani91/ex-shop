defmodule Ap.Repo.Migrations.CreatePostCategories do
  use Ecto.Migration

  def change do
    create table(:post_categories) do
      add :title, :string
      add :slug, :string
      add :description, :text

      timestamps()
    end

  end
end
