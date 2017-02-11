ExUnit.start

alias Reviewcast.Podcast
alias Reviewcast.Repo.PodcastRepo

# Ecto.Adapters.SQL.Sandbox.mode(Reviewcast.Repo, :manual)

defmodule Reviewcast.Test do

  def create_podcasts(num \\ 10) do
    1..num
    |> Enum.map(&build_podcast_map(&1))
    |> PodcastRepo.import
  end

  def build_podcast_map(i \\ 1, params \\ %{}) do
    %{
      title: "Podcast #{i}",
      source: "itunes",
      description: "A great #{i} podcast.",
      html_url: "https://itunes.apple.com/us/podcast/crimetown/id1170959623?mt=2&ign-mpt=uo%3D2",
      image_url: "http://is2.mzstatic.com/image/thumb/Music71/v4/f1/31/3a/f1313a60-f63f-3be9-31aa-5fbd5832a196/source/170x170bb.jpg",
      source_id: "#{i}"
    } |> Map.merge(params)
  end

  def build_podcast(i \\ 1, params \\ %{}) do
    %Podcast{
      title: "Podcast #{i}",
      source: "itunes",
      description: "A great #{i} podcast.",
      html_url: "https://itunes.apple.com/us/podcast/crimetown/id1170959623?mt=2&ign-mpt=uo%3D2",
      image_url: "http://is2.mzstatic.com/image/thumb/Music71/v4/f1/31/3a/f1313a60-f63f-3be9-31aa-5fbd5832a196/source/170x170bb.jpg",
      source_id: "#{i}"
    } |> Map.merge(params)
  end
end
