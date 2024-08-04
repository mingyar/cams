defmodule CamsWeb.CameraJSON do
  alias Cams.Cameras.Camera

  @doc """
  Renders a list of cameras.
  """
  def index(%{cameras: cameras}) do
    %{data: for(camera <- cameras, do: data(camera))}
  end

  @doc """
  Renders a single camera.
  """
  def show(%{camera: camera}) do
    %{data: data(camera)}
  end

  def data(%Camera{} = camera) do
    %{
      id: camera.id,
      brand: camera.brand,
      status: camera.status
    }
  end
end
