defmodule Commander.Repo.Migrations.CreateAggregates do
  use Ecto.Migration

  def change do
    create table("aggregate", primary_key: false) do
      add :entity_id, :string, primary_key: true
      add :offset, :integer
      add :body, :map

      unique_index(:aggregate, [:entity_id])
    end
  end
end
