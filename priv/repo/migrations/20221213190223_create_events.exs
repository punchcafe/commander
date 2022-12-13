defmodule Commander.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table("event") do
      add :event_type,    :string, size: 40
      add :entity_id, :integer
      add :offset, :integer
      add :body, :map
      timestamps(updated_at: false)
    end

    create unique_index(:event, [:entity_id, :offset], name: :entity_id_offset_index)
  end
end
