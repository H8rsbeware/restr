defmodule RestrWeb.Router do
  use RestrWeb, :router
  import RestrWeb.AuthController, only: [auth_api_user: 2]

  pipeline :api do
    plug :accepts, ["json"]
    plug RestrWeb.AuthController
  end


  scope "/api", RestrWeb do
    pipe_through [:api, :auth_api_user]
    resources "/users", UserController, except: [:edit]
    resources "/venues", VenueController
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: RestrWeb.Telemetry
    end
  end
end
