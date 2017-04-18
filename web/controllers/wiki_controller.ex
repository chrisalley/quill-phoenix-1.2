defmodule Quill.WikiController do
  use Quill.Web, :controller

  alias Quill.Wiki

  def index(conn, _params) do
    wikis = Repo.all(Wiki)
    render(conn, "index.html", wikis: wikis)
  end

  def new(conn, _params) do
    changeset = Wiki.changeset(%Wiki{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"wiki" => wiki_params}) do
    changeset = Wiki.changeset(%Wiki{}, wiki_params)

    case Repo.insert(changeset) do
      {:ok, _wiki} ->
        conn
        |> put_flash(:info, "Wiki created successfully.")
        |> redirect(to: wiki_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    wiki = Repo.get!(Wiki, id)
    render(conn, "show.html", wiki: wiki)
  end

  def edit(conn, %{"id" => id}) do
    wiki = Repo.get!(Wiki, id)
    changeset = Wiki.changeset(wiki)
    render(conn, "edit.html", wiki: wiki, changeset: changeset)
  end

  def update(conn, %{"id" => id, "wiki" => wiki_params}) do
    wiki = Repo.get!(Wiki, id)
    changeset = Wiki.changeset(wiki, wiki_params)

    case Repo.update(changeset) do
      {:ok, wiki} ->
        conn
        |> put_flash(:info, "Wiki updated successfully.")
        |> redirect(to: wiki_path(conn, :show, wiki))
      {:error, changeset} ->
        render(conn, "edit.html", wiki: wiki, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    wiki = Repo.get!(Wiki, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(wiki)

    conn
    |> put_flash(:info, "Wiki deleted successfully.")
    |> redirect(to: wiki_path(conn, :index))
  end
end
