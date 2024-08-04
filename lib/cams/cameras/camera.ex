defmodule Cams.Cameras.Camera do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cameras" do
    field :status, :boolean, default: false
    field :brand, :string
    belongs_to :user, Cams.Accounts.User, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(camera, attrs) do
    camera
    |> cast(attrs, [:user_id, :brand, :status])
    |> validate_required([:brand])
  end
end
