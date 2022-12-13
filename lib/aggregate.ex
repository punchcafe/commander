defmodule Commander.Aggregate do
    use Ecto.Schema

    schema "aggregate" do
        field :entity_id, :integer
        field :offset, :integer
        field :body, :map
    end
end