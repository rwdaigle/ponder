defmodule Reviewcast.PodcastRepoTest do

  use ExUnit.Case, async: true

  import Ecto.Query
  import Reviewcast.Test

  alias Reviewcast.Podcast
  alias Reviewcast.Repo
  alias Reviewcast.Repo.PodcastRepo

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Reviewcast.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Reviewcast.Repo, {:shared, self()})
  end

  test "inserting a podcast" do
    podcast = PodcastRepo.insert!(build_podcast())
    assert PodcastRepo.count == 1
    assert podcast != nil
    assert podcast.title == "Podcast 1"
    assert podcast.id != nil
  end

  test "importing podcasts" do
    1..10
    |> Enum.map(&build_podcast_map(&1))
    |> PodcastRepo.import

    assert PodcastRepo.count == 10
  end

  test "updates existing podcasts on import" do
    1..10
    |> Enum.map(&build_podcast_map(&1))
    |> PodcastRepo.import

    [build_podcast_map(1, %{title: "Updated podcast"})]
    |> PodcastRepo.import

    assert PodcastRepo.count == 10
    podcast = Repo.one(from p in Podcast, where: p.source == "itunes" and p.source_id == "1")
    assert podcast != nil
    assert podcast.title == "Updated podcast"
  end

  test "can handle large imports" do
    1..21000
    |> Enum.map(&build_podcast_map(&1))
    |> PodcastRepo.import

    assert PodcastRepo.count == 21000
  end
end
