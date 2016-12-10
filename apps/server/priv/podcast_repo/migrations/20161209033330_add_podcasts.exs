defmodule Server.PodcastRepo.Migrations.AddPodcasts do
  use Ecto.Migration

  def change do
    create table(:podcasts) do
      add :title, :string
      add :description, :string
      add :source, :string
      add :source_id, :string
      add :html_url, :string
      add :image_url, :string

      timestamps
    end
  end
end
