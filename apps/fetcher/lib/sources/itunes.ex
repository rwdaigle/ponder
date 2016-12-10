defmodule Fetcher.Source.ITunes do

  @behaviour Fetcher.Source

  alias Fetcher.Source
  alias ReviewCast.Model.Podcast
  alias HTTPotion.Response
  alias Poison.Parser, as: JSON

  @recent_url "https://itunes.apple.com/us/rss/toppodcasts/limit=200/explicit=true/json"

  def recent do
    with %Response{body: body, status_code: 200} <- HTTPotion.get(@recent_url),
         %{"feed" => %{"entry" => itunes_entries} } <- JSON.parse!(body) do
      parse_entries(itunes_entries)
    end
  end

  defp parse_entries(entries) do
    entries |> Enum.map(fn(e) -> parse_entry(e) end)
  end

  defp parse_entry(entry) do
    params = %{
      title: get_in(entry, ["im:name", "label"]),
      source: "itunes",
      description: get_in(entry, ["summary", "label"]),
      html_url: get_in(entry, ["link", "attributes", "href"]),
      image_url: image_url(entry),
      source_id: get_in(entry, ["id", "attributes", "im:id"])
    }

    with {:ok, podcast} <- Source.podcast(params) do
      podcast
    end
  end

  defp image_url(entry) do
    entry
    |> get_in(["im:image"])
    |> List.last
    |> Map.get("label")
  end
end
