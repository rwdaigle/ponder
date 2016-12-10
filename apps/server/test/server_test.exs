defmodule ServerTest do

  use ExUnit.Case, async: true
  import Ecto.Query
  alias ReviewCast.Podcast
  alias Server.PodcastRepo

  test "importing podcasts" do
    1..10
    |> Enum.map(&podcast(&1))
    |> Server.import

    assert PodcastRepo.one(from p in Podcast, select: count(p.id)) == 10
  end

  defp podcast(i) do
    %Podcast{
      title: "Podcast #{i}",
      source: "itunes",
      description: "A great #{i} podcast.",
      html_url: "https://itunes.apple.com/us/podcast/crimetown/id1170959623?mt=2&ign-mpt=uo%3D2",
      image_url: "http://is2.mzstatic.com/image/thumb/Music71/v4/f1/31/3a/f1313a60-f63f-3be9-31aa-5fbd5832a196/source/170x170bb.jpg",
      source_id: "#{i}"
    }
  end
end
