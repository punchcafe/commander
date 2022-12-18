defmodule Commander.Event do
  use Ecto.Schema

  # Temporarily couple module to persistence
  @primary_key false
  schema "event" do
    field(:entity_id, :binary, primary_key: true)
    field(:offset, :integer, primary_key: true)
    field(:event_type, :string)
    field(:body, :map)
    timestamps(updated_at: false)
  end

  def set_offset(event, offset) do
    %{event | offset: offset}
  end

  def entity_id(event) do
    event.entity_id
  end

  def set_entity_id(event, entity_id) do
    %{event | entity_id: entity_id}
  end
end
