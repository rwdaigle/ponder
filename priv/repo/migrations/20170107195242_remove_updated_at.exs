defmodule Reviewcast.Repo.Migrations.RemoveUpdatedAt do
  use Ecto.Migration

  def change do
    alter table(:podcasts) do
      remove :updated_at
    end
  end
end
