defmodule Quill.SessionController do
  use Quill.Web, :controller

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(
    conn, %{"session" => %{"email" => email, "password" => password}}
  ) do
    case login_with_email_and_password(conn, email, password) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: wiki_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination.")
        |> render("new.html")
    end
  end

  defp login_with_email_and_password(conn, email, password) do
    user = Repo.get_by(Quill.User, email: email)

    cond do
      user && checkpw(password, user.encrypted_password) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  defp login(conn, user) do
    # Todo
    conn
  end
end
