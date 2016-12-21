defmodule Fetcher.Source.ITunes do

  @behaviour Fetcher.Source

  alias HTTPotion.Response
  alias Fetcher.Source.ITunes
  alias Poison.Parser, as: JSON

  def recent do
    categories()
    |> Enum.map(&Task.async(ITunes, :fetch_feed, [&1]))
    |> Enum.map(&Task.await(&1, 120000))
    |> List.flatten
    |> Enum.uniq_by(fn p -> {p.source, p.source_id} end)
  end

  def fetch_feed(category_id) do
    url = "https://itunes.apple.com/us/rss/toppodcasts/genre=#{category_id}/limit=200/explicit=true/json"
    with %Response{body: body, status_code: 200} <- HTTPotion.get(url),
         %{"feed" => %{"entry" => itunes_entries} } <- JSON.parse!(body) do
      parse_entries(itunes_entries)
    else
      _ -> []
    end
  end

  defp parse_entries(entries) do
    entries |> Enum.map(fn(e) -> parse_entry(e) end)
  end

  defp parse_entry(entry) do
    %{
      title: get_in(entry, ["im:name", "label"]),
      source: "itunes",
      description: get_in(entry, ["summary", "label"]),
      html_url: get_in(entry, ["link", "attributes", "href"]),
      image_url: image_url(entry),
      source_id: get_in(entry, ["id", "attributes", "im:id"])
    }
  end

  defp image_url(entry) do
    entry
    |> get_in(["im:image"])
    |> List.last
    |> Map.get("label")
  end

  # https://itunes.apple.com/us/rss/toppodcasts/genre=1402/json
  defp categories do
    [26, 1301, 1306, 1401, 1402, 1405, 1406, 1459, 1303, 1304, 1415, 1416, 1468, 1469, 1470, 1305, 1307, 1417, 1420, 1421, 1481, 1309, 1310, 1311, 1314, 1438, 1439, 1440, 1441, 1444, 1463, 1464, 1315, 1477, 1478, 1479, 1316, 1456, 1465, 1466, 1467, 1318, 1446, 1448, 1450, 1480, 1321, 1410, 1412, 1413, 1471, 1472, 1323, 1404, 1454, 1455, 1460, 1461, 1324, 1302, 1320, 1443, 1462, 1325, 1473, 1474, 1475, 1476, 1476]
  end
end
