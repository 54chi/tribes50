defmodule Pepe02Api.Repo.Migrations.CreateStory do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :title, :string
      add :content, :string

      timestamps
    end

  end
end
