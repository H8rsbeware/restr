defmodule Restr.Accounts.Venue do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "venues" do
    field :name, :string
    field :capacity, :integer
    field :hearts, :integer
    field :location, :string
    field :popularity, :float
    timestamps()
  end

  @doc false
  def changeset(venue, attrs) do
    venue
    |> cast(attrs, [:name, :capacity, :hearts, :popularity, :location])
    |> validate_required([:name, :capacity, :location])
    |> unique_constraint(:location)
  end
end
