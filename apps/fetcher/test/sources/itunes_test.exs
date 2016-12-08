defmodule ITunesSourceTest do

  use ExUnit.Case, async: true
  @moduletag :remote

  alias Fetcher.Source.ITunes, as: Source
  alias ReviewCast.Podcast

  test "fetches recent podcasts" do
    recent_podcasts = Source.recent
    assert Enum.count(recent_podcasts) == 200
    # recent_podcasts |> Enum.each(fn(p) -> IO.inspect(p) end)
    recent_podcasts |> Enum.each(fn(p) -> %Podcast{source: "itunes"} = p end)
  end
end
