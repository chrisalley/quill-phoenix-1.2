defmodule Quill.Router do
  use Quill.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Quill do
    pipe_through :browser # Use the default browser stack

    get "/", WikiController, :index
    resources "/wikis", WikiController
    resources "/pages", PageController
    resources "/profiles", ProfileController
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Quill do
  #   pipe_through :api
  # end
end
