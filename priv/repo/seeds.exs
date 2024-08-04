# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cams.Repo.insert!(%Cams.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule Cams.Seeds do
  import Ecto.Query

  alias Cams.Repo
  alias Cams.Users.{User}
  alias Cams.Cameras.{Camera}

  users =
    1..1000
    |> Enum.map(fn _ ->
      %{
        name: Faker.Name.name(),
        inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
        updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
      }
    end)

  {_, users} = Repo.insert_all(User, users, returning: [:id])

  cameras =
    users
    |> Enum.map(fn %{id: user_id} ->
      1..50
      |> Enum.map(fn _ ->
        %{
          brand: Enum.random(["Intelbras", "Hikvision", "Giga", "Vivotek"]),
          status: Enum.random([true, false]),
          user_id: user_id,
          inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
          updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
        }
      end)
    end)
    |> List.flatten()

  cameras
  |> Enum.chunk_every(10_000)
  |> Enum.each(&Repo.insert_all(Camera, &1))
end
