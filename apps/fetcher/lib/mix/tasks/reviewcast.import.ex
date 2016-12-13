defmodule Mix.Tasks.Reviewcast.Import do
  use Mix.Task

  @shortdoc "Import podcasts from all source"
  def run(_) do
    {:ok, _fetcher} = Application.ensure_all_started(:fetcher)
    {:ok, _server} = Application.ensure_all_started(:server)
    IO.puts "Importing..."
    Fetcher.fetch_sources
    |> Enum.map(fn(p) -> IO.puts(p.title); p end)
    |> Reviewcast.import
  end
end
