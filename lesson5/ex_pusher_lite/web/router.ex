defmodule ExPusherLite.Router do
  use ExPusherLite.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :guardian do
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/", ExPusherLite do
    pipe_through [ :browser ]

    get "/", PageController, :index
    post "/events", EventsController, :create
  end

  scope "/api", ExPusherLite do
    pipe_through [ :api, :guardian ]

    post "/apps/:app_slug/events", EventsController, :create

    scope "/admin" do
      resources "/apps", AppController, except: [:new, :edit]
    end
  end
end
