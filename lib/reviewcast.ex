defmodule Reviewcast do

  alias Reviewcast.Repo.PodcastRepo

  def import(podcast = %{}), do: Reviewcast.import([podcast])
  def import(podcasts) do
    podcasts |> PodcastRepo.import
  end
end
