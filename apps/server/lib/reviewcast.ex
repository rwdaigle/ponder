defmodule ReviewCast do

  import Ecto.Changeset
  import Ecto.Query
  alias ReviewCast.Model.Podcast
  alias ReviewCast.Repo

  def import(podcasts) do
    podcasts
    |> Enum.map(&Task.async(ReviewCast, :import_podcast, [&1]))
    |> Enum.map(&Task.await(&1, 30000))
    |> List.flatten
  end

  def import_podcast(podcast = %Podcast{}) do
    query = from p in Podcast,
      where: p.source == ^podcast.source and p.source_id == ^podcast.source_id

    Repo.one(query)
    |> upsert_podcast(podcast)
  end

  defp upsert_podcast(nil, new), do: Repo.insert(new)
  defp upsert_podcast(existing, new) do
    existing
    |> cast(Map.from_struct(new), [:title, :description, :html_url, :image_url])
    |> Repo.update
  end
end
