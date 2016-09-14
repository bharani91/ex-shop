defmodule Ap.Page do
  use Ap.Web, :model
  import Ap.Utils.Sluggify

  schema "pages" do
    field :title, :string
    field :page_title, :string
    field :content, :string
    field :slug, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :page_title, :content, :slug])
    |> validate_required([:title, :page_title, :content])
    |> sluggify
    |> validate_required([:slug])
    |> unique_constraint(:slug)
  end
end
