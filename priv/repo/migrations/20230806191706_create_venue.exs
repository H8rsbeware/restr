defmodule Restr.Repo.Migrations.CreateVenue do
  use Ecto.Migration

  def change do
    create table(:venues, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false, size: 50
      add :hearts, :integer
      add :capacity, :integer, null: false
      add :location, :string, null: false, size: 150
      add :popularity, :float
      timestamps()
    end
    create unique_index(:venues, [:id, :location])
  end
end
