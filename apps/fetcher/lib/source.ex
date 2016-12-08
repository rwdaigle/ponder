defmodule Fetcher.Source do
  alias Fetcher.Podcast
  @callback recent() :: [%Podcast{}]
end
