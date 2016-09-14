defmodule Ap.SupportMessage do
  use Ap.Web, :model

  schema "support_messages" do
    field :name, :string
    field :email, :string
    field :subject, :string
    field :content, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :subject, :content])
    |> validate_required([:name, :email, :subject, :content])
  end
end
