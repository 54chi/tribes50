defmodule Pepe01.Router do
  use Pepe01.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Openmaize.Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Pepe01 do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/confirm", PageController, :confirm
    get "/askreset", PageController, :askreset
    post "/askreset", PageController, :askreset_password
    get "/reset", PageController, :reset
    post "/reset", PageController, :reset_password
    get "/login", PageController, :login, as: :login
    post "/login", PageController, :login_user, as: :login
    get "/logout", PageController, :logout, as: :logout
  end

  scope "/users", Pepe01 do
    pipe_through :browser

    resources "/", UserController, only: [:index, :show, :edit, :update]
  end

  scope "/admin", Pepe01 do
    pipe_through :browser

    get "/", AdminController, :index
    resources "/users", AdminController, only: [:new, :create, :delete]
  end


  # Other scopes may use custom stacks.
  # scope "/api", Pepe01 do
  #   pipe_through :api
  # end
end
