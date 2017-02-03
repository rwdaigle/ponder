defmodule ITunesSourceTest do

  use ExUnit.Case, async: true
  @moduletag :remote

  alias Reviewcast.Fetcher.Source.ITunes, as: Source

  test "fetches recent podcasts" do
    recent_podcasts = Source.recent
    assert Enum.count(recent_podcasts) >= 1000
    # recent_podcasts |> Enum.each(fn(p) -> IO.inspect(p) end)
    recent_podcasts |> Enum.each(fn(p) -> %{source: "itunes"} = p end)
  end
end
