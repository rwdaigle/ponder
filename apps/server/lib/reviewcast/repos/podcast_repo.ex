defmodule Reviewcast.Repo.PodcastRepo do

  import Ecto.Changeset
  import Ecto.Query
  alias Reviewcast.Repo
  alias Reviewcast.Model.Podcast

  def import(podcasts) do
    podcasts |> Enum.each(&import_podcast(&1))
  end

  def import_podcast(params = %{}) do
    query = from p in Podcast,
      where: p.source == ^params.source and p.source_id == ^params.source_id

    Repo.one(query, repo_options())
    |> upsert_podcast(params)
  end

  defp upsert_podcast(nil, params) do
    changeset =
      %Podcast{}
      |> cast(params, [:title, :description, :source, :source_id, :html_url, :image_url])

    cond do
      changeset.valid? -> Repo.insert(changeset, repo_options())
      true -> {:error, changeset}
    end
  end

  defp upsert_podcast(existing, params) do
    existing
    |> cast(params, [:title, :description, :html_url, :image_url])
    |> Repo.update
  end

  defp repo_options, do: [timeout: 10000, pool_timeout: 30000]
end
