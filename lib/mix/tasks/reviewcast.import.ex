defmodule Mix.Tasks.Reviewcast.Import do
  use Mix.Task
  alias Reviewcast.Repo.PodcastRepo

  @shortdoc "Import podcasts from all source"
  def run(_) do
    {:ok, _reviewcast} = Application.ensure_all_started(:reviewcast)
    IO.write "Importing "

    Reviewcast.Fetcher.fetch_sources
    |> Enum.map(fn(p) -> IO.write("."); p end)
    |> PodcastRepo.import

    IO.puts "done"
  end
end
