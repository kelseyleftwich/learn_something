defmodule LearnSomethingWeb.Router do
  use LearnSomethingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LearnSomethingWeb do
    pipe_through :browser

    live "/", DashboardLive.Index
    live "/register", UserLive.New
    # get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", LearnSomethingWeb do
  #   pipe_through :api
  # end
end
