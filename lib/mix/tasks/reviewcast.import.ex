defmodule Mix.Tasks.Reviewcast.Import do
  use Mix.Task

  @shortdoc "Import podcasts from all source"
  def run(_) do
    {:ok, _server} = Application.ensure_all_started(:server)
    Fetcher.fetch_sources
    |> Enum.map(fn(p) -> IO.puts("Importing #{p.source}:#{p.source_id} #{p.title}"); p end)
    |> Reviewcast.import
  end
end
