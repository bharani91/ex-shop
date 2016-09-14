defmodule Ap.Repo.Migrations.CreatePostsCategories do
  use Ecto.Migration

  def change do
    create table(:posts_categories) do
      add :post_id, references(:posts)
      add :post_category_id, references(:post_categories)
    end
  end
end
