defmodule Pepe02Api.V1.StoryControllerTest do
  use Pepe02Api.ConnCase

  alias Pepe02Api.V1.Story
  @valid_attrs %{content: "some content", title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, story_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    story = Repo.insert! %Story{}
    conn = get conn, story_path(conn, :show, story)
    assert json_response(conn, 200)["data"] == %{"id" => story.id,
      "title" => story.title,
      "content" => story.content}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, story_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, story_path(conn, :create), story: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Story, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, story_path(conn, :create), story: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    story = Repo.insert! %Story{}
    conn = put conn, story_path(conn, :update, story), story: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Story, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    story = Repo.insert! %Story{}
    conn = put conn, story_path(conn, :update, story), story: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    story = Repo.insert! %Story{}
    conn = delete conn, story_path(conn, :delete, story)
    assert response(conn, 204)
    refute Repo.get(Story, story.id)
  end
end
