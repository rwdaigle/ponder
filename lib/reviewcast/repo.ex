defmodule Reviewcast.Repo do
  use Ecto.Repo, otp_app: :reviewcast
end

defmodule Reviewcast.Repo.PodcastRepo do

  alias Reviewcast.Repo
  alias Reviewcast.Podcast

  import Ecto.Query

  def all, do: Repo.all(from p in Podcast)
  def all(limit \\ 10), do: Repo.all(from p in Podcast, limit: ^limit)
  def count, do: Repo.one(from p in Podcast, select: count(p.id))

  def insert!(podcast = %Podcast{}), do: Repo.insert!(podcast)

  def import(podcasts) do
    podcasts
    |> Enum.chunk(500, 500, [])
    |> Enum.each(&insert(&1))
  end

  defp insert(podcasts) do
    Repo.insert_all(Podcast, podcasts, Keyword.merge(insert_options(), repo_options()))
  end

  defp insert_options, do: [on_conflict: :replace_all, conflict_target: [:source, :source_id]]
  defp repo_options, do: [timeout: 10000, pool_timeout: 30000]
end
