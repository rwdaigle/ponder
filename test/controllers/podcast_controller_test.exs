defmodule Reviewcast.PodcastControllerTest do

  use Reviewcast.ConnCase
  alias Reviewcast.Podcast
  alias Reviewcast.Repo.PodcastRepo
  import Reviewcast.Test

  @valid_attrs %{}
  @invalid_attrs %{}

  test "list podcasts", %{conn: conn} do
    create_podcasts(20)
    conn = get conn, podcast_path(conn, :index)
    assert html_response(conn, 200) =~ "Podcasts"

    PodcastRepo.all(10)
    |> Enum.each(fn(p) -> assert html_response(conn, 200) =~ p.title end)

    PodcastRepo.all(20)
    |> Enum.slice(11..20)
    |> Enum.each(fn(p) -> refute html_response(conn, 200) =~ p.title end)
  end
  
  # test "renders form for new resources", %{conn: conn} do
  #   conn = get conn, podcast_path(conn, :new)
  #   assert html_response(conn, 200) =~ "New podcast"
  # end
  #
  # test "creates resource and redirects when data is valid", %{conn: conn} do
  #   conn = post conn, podcast_path(conn, :create), podcast: @valid_attrs
  #   assert redirected_to(conn) == podcast_path(conn, :index)
  #   assert Repo.get_by(Podcast, @valid_attrs)
  # end
  #
  # test "does not create resource and renders errors when data is invalid", %{conn: conn} do
  #   conn = post conn, podcast_path(conn, :create), podcast: @invalid_attrs
  #   assert html_response(conn, 200) =~ "New podcast"
  # end

  test "shows chosen resource", %{conn: conn} do
    podcast = PodcastRepo.insert!(build_podcast)
    conn = get conn, podcast_path(conn, :show, podcast)
    assert html_response(conn, 200) =~ podcast.title
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, podcast_path(conn, :show, -1)
    end
  end

  # test "renders form for editing chosen resource", %{conn: conn} do
  #   podcast = Repo.insert! %Podcast{}
  #   conn = get conn, podcast_path(conn, :edit, podcast)
  #   assert html_response(conn, 200) =~ "Edit podcast"
  # end
  #
  # test "updates chosen resource and redirects when data is valid", %{conn: conn} do
  #   podcast = Repo.insert! %Podcast{}
  #   conn = put conn, podcast_path(conn, :update, podcast), podcast: @valid_attrs
  #   assert redirected_to(conn) == podcast_path(conn, :show, podcast)
  #   assert Repo.get_by(Podcast, @valid_attrs)
  # end
  #
  # test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
  #   podcast = Repo.insert! %Podcast{}
  #   conn = put conn, podcast_path(conn, :update, podcast), podcast: @invalid_attrs
  #   assert html_response(conn, 200) =~ "Edit podcast"
  # end
  #
  # test "deletes chosen resource", %{conn: conn} do
  #   podcast = Repo.insert! %Podcast{}
  #   conn = delete conn, podcast_path(conn, :delete, podcast)
  #   assert redirected_to(conn) == podcast_path(conn, :index)
  #   refute Repo.get(Podcast, podcast.id)
  # end
end
