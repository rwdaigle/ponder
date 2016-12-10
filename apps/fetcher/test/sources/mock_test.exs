defmodule MockSourceTest do

  use ExUnit.Case, async: true
  alias Fetcher.Source.Mock, as: Source
  alias ReviewCast.Model.Podcast

  test "fetches recent podcasts" do
    recent_podcasts = Source.recent
    assert Enum.count(recent_podcasts) == 200
    # recent_podcasts |> Enum.each(fn(p) -> IO.inspect(p) end)
    recent_podcasts |> Enum.each(fn(p) -> %Podcast{} = p end)
  end
end
