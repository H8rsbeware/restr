defmodule Restr.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :tag, :integer
      add :email, :string
      add :admin, :boolean
      add :top_venue, references(:venues, column: :id, type: :binary_id)
      add :following, {:array, :binary_id}

      timestamps()
    end
    create unique_index(:users, [:id, :email])
  end
end
