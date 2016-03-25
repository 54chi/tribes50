ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Tribes50.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Tribes50.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Tribes50.Repo)

