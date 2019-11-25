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

  pipeline :logged_in do
    plug LearnSomething.AuthenticationPlug
  end

  scope "/", LearnSomethingWeb do
    pipe_through [:browser, :logged_in]

    get "/login", LoginController, :index
    post "/login", LoginController, :login
  end

  scope "/", LearnSomethingWeb do
    pipe_through [:browser, :logged_in]

    live "/", DashboardLive.Index, session: [:user_id]
  end

  # Other scopes may use custom stacks.
  # scope "/api", LearnSomethingWeb do
  #   pipe_through :api
  # end
end
