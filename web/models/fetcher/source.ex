defmodule Reviewcast.Fetcher.Source do
  @callback recent() :: [%{}]
end
