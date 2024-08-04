defmodule Cams.CamerasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cams.Cameras` context.
  """

  @doc """
  Generate a camera.
  """
  def camera_fixture(attrs \\ %{}) do
    {:ok, camera} =
      attrs
      |> Enum.into(%{
        brand: "some brand",
        status: true
      })
      |> Cams.Cameras.create_camera()

    camera
  end
end
