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

  def delete(conn, _) do
    conn
    |> logout()
    |> redirect(to: wiki_path(conn, :index))
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
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  defp logout(conn) do
    configure_session(conn, drop: true)
  end
end
