defmodule Ap.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password_hash, :string
      add :bio, :text
      add :twitter_url, :string
      add :github_url, :string
      add :website_url, :string

      timestamps()
    end

    create unique_index(:users, [:email])

  end
end
