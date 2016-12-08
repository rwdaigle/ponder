defmodule Fetcher.Source.ITunes do

  @behaviour Fetcher.Source

  alias ReviewCast.Podcast
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
    with title = entry |> get_in(["im:name", "label"]),
         html_url = entry |> get_in(["link", "attributes", "href"]),
         source_id = entry |> get_in(["id", "attributes", "im:id"]),
         description = entry |> get_in(["summary", "label"]),
         images = entry |> get_in(["im:image"]),
         image_url = images |> List.last |> Map.get("label") do

      %Podcast{
        title: title,
        source: "itunes",
        description: description,
        html_url: html_url,
        image_url: image_url,
        source_id: source_id
      }
    end
  end
end
