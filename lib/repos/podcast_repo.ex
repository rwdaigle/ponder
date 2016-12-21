defmodule Reviewcast.Repo.PodcastRepo do

  alias Reviewcast.Repo
  alias Reviewcast.Model.Podcast

  def import(podcasts) do
    podcasts
    |> Enum.map(&(Map.put(&1, :updated_at, Ecto.DateTime.utc)))
    |> Enum.chunk(500, 500, [])
    |> Enum.each(&insert(&1))
  end

  defp insert(podcasts) do
    Repo.insert_all(Podcast, podcasts, Keyword.merge(insert_options(), repo_options()))
  end

  defp insert_options, do: [on_conflict: :replace_all, conflict_target: [:source, :source_id]]
  defp repo_options, do: [timeout: 10000, pool_timeout: 30000]
end
