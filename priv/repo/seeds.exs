# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Restr.Repo.insert!(%Restr.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Restr.Repo
alias Restr.Accounts.User
alias Restr.Accounts.Venue

defmodule Restr.DatabaseSeeder do

  def create_random_string(n) do
    _s = for _ <- 1..n, into: "", do: <<Enum.random(?a..?z)>>
  end

  def insert_user() do
    str = create_random_string(10)
    Repo.insert! %User{
      name: "#{str}",
      tag:  :rand.uniform(9000)+999,
      email: "#{str}@email.com",
      admin: false
    }
  end

  def insert_venue() do
    str = create_random_string(10)
    str2 = create_random_string(50)
    Repo.insert! %Venue{
      name: "#{str}",
      capacity: :rand.uniform(20)*10,
      location: "#{str2}"
    }
  end
end


Repo.delete_all(User)
Repo.delete_all(Venue)
(1..100) |> Enum.each(fn _ -> Restr.DatabaseSeeder.insert_user() end)
(1..30) |> Enum.each(fn _ -> Restr.DatabaseSeeder.insert_venue() end)
