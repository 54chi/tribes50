ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Pepe02Api.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Pepe02Api.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Pepe02Api.Repo)

