defmodule Ap.Utils.ManyToMany do
  import Ecto.Changeset, only: [put_assoc: 3, change: 1]
  import Ecto.Query, only: [from: 2]

  def map_many_to_many_ids_to_records(changeset, assoc, model) do
    case Map.fetch(changeset.params, to_string(assoc)) do
      {:ok, ids} ->
        changes =
          ids
          |> all(Ap.Repo, model)
          |> Enum.map(&change/1)
        put_assoc(changeset, assoc, changes)
      :error ->
        changeset
    end
  end

  defp all(ids, repo, mod) do
    repo.all(from m in mod, where: m.id in ^ids)
  end
end
