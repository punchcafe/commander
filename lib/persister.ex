defmodule Commander.Persister do
  alias Commander.Event
  alias Commander.Aggregate

  def persist(aggregate, events) do
    offset = Aggregate.offset(aggregate)
    {new_offset, events} = label_events(offset + 1, Aggregate.entity_id(aggregate), events)
    aggregate = Aggregate.set_offset(aggregate, new_offset)
    case atomic_save(aggregate, events) do
        {:ok, %{agg: new_agg = %Commander.Aggregate{}}} ->
            {:ok, new_agg}
    end
  end

  def new_agg(id) when is_binary(id) do
    %Commander.Aggregate{}
    |> Ecto.Changeset.change(%{entity_id: id, offset: 0})
    |> Commander.Repo.insert()
  end

  # Extract to Repository model
  defp atomic_save(aggregate, events) do
    events
    |> Enum.with_index()
    |> Enum.reduce(Ecto.Multi.new(), fn {event, index}, multi ->
      Ecto.Multi.insert(
        multi,
        :"event_#{index}",
        Ecto.Changeset.cast(%Commander.Event{}, Map.from_struct(event), [
          :body,
          :entity_id,
          :event_type,
          :offset
        ])
      )
    end)
    |> Ecto.Multi.update(
      :agg,
      Ecto.Changeset.cast(%Commander.Aggregate{entity_id: aggregate.entity_id}, Map.from_struct(aggregate), [:body, :offset])
    )
    |> Commander.Repo.transaction()
  end

  @spec label_events(from :: integer(), entity_id :: integer(), events :: [Event.t()]) ::
          {last_offset :: integer(), events :: [Event.t()]}
  defp label_events(from, entity_id, events) do
    events =
      events
      |> Enum.with_index(from)
      |> Enum.map(fn {event, offset} -> Event.set_offset(event, offset) end)
      |> Enum.map(fn event -> Event.set_entity_id(event, entity_id) end)

    %{offset: last_offset} = Enum.at(events, -1)
    {last_offset, events}
  end
end
