defmodule CamsWeb.UserJSON do
  alias Cams.Users.User
  alias CamsWeb.CameraJSON

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{cameras: %Ecto.Association.NotLoaded{}} = user) do
    %{
      id: user.id,
      name: user.name
    }
  end

  defp data(%User{cameras: cameras} = user) do
    %{
      id: user.id,
      name: user.name,
      cameras: cameras |> Enum.map(&CameraJSON.data/1)
    }
  end
end
