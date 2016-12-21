defmodule Reviewcast.Repo.Migrations.AddPodcastSourceConstraint do
  use Ecto.Migration

  def change do
    create index(:podcasts, [:source, :source_id], unique: true)
  end
end
