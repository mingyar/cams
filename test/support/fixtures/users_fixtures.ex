defmodule Cams.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cams.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Cams.Users.create_user()

    user
  end
end
