defmodule Ap.Utils.DowncaseEmail do
  import Ecto.Changeset, only: [put_change: 3]

  def downcase_email(%{valid?: true, changes: %{email: email}}=changeset) do
    put_change(changeset, :email, email |> String.downcase)
  end
  def downcase_email(changeset), do: changeset
end
