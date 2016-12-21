defmodule FetcherTest do

  use ExUnit.Case, async: true

  test "fetches from sources" do
    podcasts = Fetcher.fetch_sources
    assert Enum.count(podcasts) >= 200
    # podcasts |> Enum.each(fn(p) -> IO.inspect(p) end)
    podcasts |> Enum.each(fn(p) -> %{} = p end)
  end
end
