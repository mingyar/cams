defmodule Cams.Repo.Migrations.CreateCameras do
  use Ecto.Migration

  def change do
    create table(:cameras, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :brand, :string
      add :status, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:cameras, [:user_id])
  end
end
