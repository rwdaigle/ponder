defmodule MockSourceTest do

  use ExUnit.Case, async: true
  alias Reviewcast.Fetcher.Source.Mock, as: Source

  test "fetches recent podcasts" do
    recent_podcasts = Source.recent
    assert Enum.count(recent_podcasts) == 200
    # recent_podcasts |> Enum.each(fn(p) -> IO.inspect(p) end)
    recent_podcasts |> Enum.each(fn(p) -> %{} = p end)
  end
end
