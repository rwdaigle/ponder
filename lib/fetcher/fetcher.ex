defmodule Reviewcast.Fetcher do

  def fetch_sources do
    Application.get_env(:reviewcast, :sources)
    |> Enum.map(&Task.async(&1, :recent, []))
    |> Enum.map(&Task.await(&1, 30000))
    |> List.flatten
  end
end
