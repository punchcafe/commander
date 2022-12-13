defmodule Commander.Application do
    
    def start(_, _) do
        children = [Commander.Repo]
        
        opts = [strategy: :one_for_one, name: MyApp.Supervisor]
        Supervisor.start_link(children, opts)
    end


    def sample(offset_1, offset_2) do
        Ecto.Multi.new()
        |> Ecto.Multi.insert(:event_1, Ecto.Changeset.change(%Commander.Event{}, %{entity_id: 1, event_type: "hello.world", offset: offset_1, body: %{}}))
        |> Ecto.Multi.insert(:event_2, Ecto.Changeset.change(%Commander.Event{}, %{entity_id: 1, event_type: "hello.world", offset: offset_2, body: %{}}))
        |> Ecto.Multi.update(:agg, Ecto.Changeset.change(%Commander.Aggregate{}, %{entity_id: 1, offset: max(offset_1, offset_2), body: %{}}))
        |> Commander.Repo.transaction()
    end
end