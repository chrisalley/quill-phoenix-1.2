defmodule Quill.PageController do
  use Quill.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
