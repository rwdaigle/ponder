defmodule Fetcher.Source do
  alias ReviewCast.Podcast
  @callback recent() :: [%Podcast{}]
end
