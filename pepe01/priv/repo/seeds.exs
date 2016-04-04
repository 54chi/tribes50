# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pepe01.Repo.insert!(%Pepe01.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


# In this example, there are several values for each user.
# The required values are `username`, `password_hash` and `role`.

users = [
  %{
    email: "admin@54chi.com",
    username: "admin",
    password_hash: Comeonin.Bcrypt.hashpwsalt("panConPescado"),
    role: "admin",
    confirmed_at: Ecto.DateTime.utc,
    bio: "I am the Admin here. My word is the rule!"
  },
  %{
    email: "user1@54chi.com",
    username: "user1",
    password_hash: Comeonin.Bcrypt.hashpwsalt("panConPescado"),
    role: "user",
    confirmed_at: Ecto.DateTime.utc,
    bio: "I was born in..."
  }
]

for user <- users do
  Map.merge(%Pepe01.User{}, user) |> Pepe01.Repo.insert!
end
