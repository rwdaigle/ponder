defmodule Fetcher.Source do

  alias ReviewCast.Model.Podcast
  import Ecto.Changeset
  @callback recent() :: [%Podcast{}]

  def podcast(params) do
    changeset =
      %Podcast{}
      |> cast(params, [:title, :description, :html_url, :image_url, :source, :source_id])
      |> validate_required([:title, :html_url])

    cond do
      changeset.valid? -> {:ok, apply_changes(changeset)}
      true -> {:error, changeset.errors}
    end
  end
end
