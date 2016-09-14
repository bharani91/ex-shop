defmodule Ap.Utils.FlashMessages do
  import Phoenix.Controller, only: [get_flash: 1]
  use Phoenix.HTML

  def show_flash(conn) do
    get_flash(conn) |> flash_msg
  end

  def flash_msg(%{"info" => msg}) do
    base_message("info", msg)
  end

  def flash_msg(%{"error" => msg}) do
    base_message("danger", msg)
  end

  def base_message(class, msg) do
    ~E"<div class='alert alert-<%= class %>'><%= msg %><button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div>"
  end

  def flash_msg(_) do
    nil
  end
end
