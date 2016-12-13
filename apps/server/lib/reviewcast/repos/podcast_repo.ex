defmodule Reviewcast.Repo.PodcastRepo do

  import Ecto.Changeset
  import Ecto.Query
  alias Reviewcast.Repo
  alias Reviewcast.Model.Podcast
  alias Reviewcast.Repo.PodcastRepo

  def import(podcasts) do
    podcasts
    |> Enum.map(&Task.async(PodcastRepo, :import_podcast, [&1]))
    |> Enum.map(&Task.await(&1, 30000))
    |> List.flatten
  end

  def import_podcast(params = %{}) do
    query = from p in Podcast,
      where: p.source == ^params.source and p.source_id == ^params.source_id

    Repo.one(query)
    |> upsert_podcast(params)
  end

  defp upsert_podcast(nil, params) do
    changeset =
      %Podcast{}
      |> cast(params, [:title, :description, :source, :source_id, :html_url, :image_url])

    cond do
      changeset.valid? -> Repo.insert(changeset)
      true -> {:error, changeset}
    end
  end

  defp upsert_podcast(existing, params) do
    existing
    |> cast(params, [:title, :description, :html_url, :image_url])
    |> Repo.update
  end
end
