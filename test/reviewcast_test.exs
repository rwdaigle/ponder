defmodule ReviewcastTest do

  use ExUnit.Case, async: true
  import Ecto.Query
  alias Reviewcast.Model.Podcast
  alias Reviewcast.Repo

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Reviewcast.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Reviewcast.Repo, {:shared, self()})
  end

  test "importing podcasts" do
    1..10
    |> Enum.map(&podcast(&1))
    |> Reviewcast.import

    assert Repo.one(from p in Podcast, select: count(p.id)) == 10
  end

  test "updates existing podcasts on import" do
    1..10
    |> Enum.map(&podcast(&1))
    |> Reviewcast.import

    podcast(1, %{title: "Updated podcast"})
    |> Reviewcast.import

    assert Repo.one(from p in Podcast, where: p.source == "itunes" and p.source_id == "1" and p.title == "Updated podcast")
  end

  test "can handle large imports" do
    1..21000
    |> Enum.map(&podcast(&1))
    |> Reviewcast.import

    assert Repo.one(from p in Podcast, select: count(p.id)) == 21000
  end

  defp podcast(i, params \\ %{}) do
    %{
      title: "Podcast #{i}",
      source: "itunes",
      description: "A great #{i} podcast.",
      html_url: "https://itunes.apple.com/us/podcast/crimetown/id1170959623?mt=2&ign-mpt=uo%3D2",
      image_url: "http://is2.mzstatic.com/image/thumb/Music71/v4/f1/31/3a/f1313a60-f63f-3be9-31aa-5fbd5832a196/source/170x170bb.jpg",
      source_id: "#{i}"
    } |> Map.merge(params)
  end
end
