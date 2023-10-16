defmodule Restr.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Restr.Accounts.User
  alias Restr.Accounts.Venue

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :tag, :integer
    field :email, :string
    embeds_one :top_venue, :binary_id
    has_many :following, User, foreign_key: :id
    field :admin, :boolean
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :tag, :email, :admin, :following])
    |> cast_assoc(:top_venue)
    |> validate_required([:name, :tag, :email, :admin])
    |> unique_constraint(:email)
  end
end
