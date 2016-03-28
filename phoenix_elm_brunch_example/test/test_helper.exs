ExUnit.start

Mix.Task.run "ecto.create", ~w(-r PhoenixElmBrunchExample.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r PhoenixElmBrunchExample.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(PhoenixElmBrunchExample.Repo)

