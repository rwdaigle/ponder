defmodule ReviewCast do

  alias ReviewCast.Repo.PodcastRepo

  def import(podcasts) do
    podcasts |> PodcastRepo.import
  end
end
