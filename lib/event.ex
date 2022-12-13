defmodule Commander.Event do
    use Ecto.Schema

    schema "event" do
        field :entity_id, :integer
        field :offset, :integer
        field :event_type, :string
        field :body, :map
        timestamps(updated_at: false)
    end
end