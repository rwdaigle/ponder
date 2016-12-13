defmodule Reviewcast do

  alias Reviewcast.Repo.PodcastRepo

  def import(podcasts) do
    podcasts |> PodcastRepo.import
  end
end
