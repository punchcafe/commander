defmodule Commander.Aggregate do
  use Ecto.Schema

  @primary_key {:entity_id, :binary, autogenerate: false}
  schema "aggregate" do
    field(:offset, :integer)
    field(:body, :map)
  end

  def offset(aggregate), do: aggregate.offset
  def entity_id(aggregate), do: aggregate.entity_id
  def set_offset(aggregate, offset), do: %{aggregate | offset: offset}
end
