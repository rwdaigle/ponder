defmodule ReviewCast.Model.Podcast do

  use Ecto.Schema
  alias ReviewCast.Model.Podcast

  schema "podcasts" do
    field :title, :string
    field :description, :string
    field :html_url, :string
    field :image_url, :string
    field :source, :string
    field :source_id, :string

    timestamps
  end
end
