defmodule CamsWeb.Router do
  use CamsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CamsWeb do
    pipe_through :api

    resources "/cameras", CameraController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:cams, :dev_routes) do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
