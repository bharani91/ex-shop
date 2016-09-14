defmodule Ap.Plugs.Authenticate do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(default), do: default

  def call(conn, _default) do
    if get_session(conn, :current_user) do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to view that page.")
      |> redirect(to: Ap.Router.Helpers.session_path(conn, :new))
      |> halt
    end
  end

end
