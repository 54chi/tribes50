ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Pepe01.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Pepe01.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Pepe01.Repo)

