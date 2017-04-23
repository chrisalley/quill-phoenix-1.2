defmodule Quill.PageController do
  use Quill.Web, :controller

  alias Quill.Wiki
  alias Quill.Page

  def index(conn, %{"wiki_id" => wiki_id}) do
    wiki = Repo.get!(Wiki, wiki_id)
    pages = Repo.all(Page |> where(wiki_id: ^wiki_id))
    render(conn, "index.html", wiki: wiki, pages: pages)
  end

  def new(conn, %{"wiki_id" => wiki_id}) do
    wiki = Repo.get!(Wiki, wiki_id)
    changeset = Page.changeset(%Page{})
    render(conn, "new.html", wiki: wiki, changeset: changeset)
  end

  def create(conn, %{"wiki_id" => wiki_id, "page" => page_params}) do
    wiki = Repo.get!(Wiki, wiki_id)
    page_params = put_in(page_params["wiki_id"], wiki_id)
    changeset = Page.changeset(%Page{}, page_params)

    case Repo.insert(changeset) do
      {:ok, _page} ->
        conn
        |> put_flash(:info, "Page created successfully.")
        |> redirect(to: wiki_page_path(conn, :index, wiki))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"wiki_id" => wiki_id, "id" => id}) do
    wiki = Repo.get!(Wiki, wiki_id)
    page = Repo.get!(Page, id)
    render(conn, "show.html", wiki: wiki, page: page)
  end

  def edit(conn, %{"wiki_id" => wiki_id, "id" => id}) do
    wiki = Repo.get!(Wiki, wiki_id)
    page = Repo.get!(Page, id)
    changeset = Page.changeset(page)
    render(conn, "edit.html", wiki: wiki, page: page, changeset: changeset)
  end

  def update(
    conn, %{"wiki_id" => wiki_id, "id" => id, "page" => page_params}
  ) do
    wiki = Repo.get!(Wiki, wiki_id)
    page = Repo.get!(Page, id)
    changeset = Page.changeset(page, page_params)

    case Repo.update(changeset) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page updated successfully.")
        |> redirect(to: wiki_page_path(conn, :show, wiki, page))
      {:error, changeset} ->
        render(conn, "edit.html", wiki: wiki, page: page, changeset: changeset)
    end
  end

  def delete(conn, %{"wiki_id" => wiki_id, "id" => id}) do
    wiki = Repo.get!(Wiki, wiki_id)
    page = Repo.get!(Page, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(page)

    conn
    |> put_flash(:info, "Page deleted successfully.")
    |> redirect(to: wiki_page_path(conn, :index, wiki))
  end
end
