defmodule Fetcher.Source do
  @callback recent() :: [%{}]
end
