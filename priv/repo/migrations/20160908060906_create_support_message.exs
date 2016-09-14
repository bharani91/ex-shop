defmodule Ap.Repo.Migrations.CreateSupportMessage do
  use Ecto.Migration

  def change do
    create table(:support_messages) do
      add :name, :string
      add :email, :string
      add :subject, :string
      add :content, :text

      timestamps()
    end

  end
end
