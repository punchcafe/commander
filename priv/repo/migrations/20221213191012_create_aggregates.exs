defmodule Commander.Repo.Migrations.CreateAggregates do
  use Ecto.Migration

  def change do
    create table("aggregate") do
      # TODO fix to disable primary key
      add :entity_id, :integer
      add :offset, :integer
      add :body, :map

      unique_index("aggregate", [:entity_id])
    end
  end
end
