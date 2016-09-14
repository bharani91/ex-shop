# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ap.Repo.insert!(%Ap.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Ap.Repo
alias Ap.User

# Admin user
changeset = User.changeset(%User{}, %{name: "Bharani", email: "test@example.com", password: "testing123"})
Repo.insert!(changeset)
