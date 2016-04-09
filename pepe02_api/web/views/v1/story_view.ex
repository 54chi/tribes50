defmodule Pepe02Api.V1.StoryView do
  use Pepe02Api.Web, :view

  def render("index.json", %{stories: stories}) do
    %{data: render_many(stories, Pepe02Api.V1.StoryView, "story.json")}
  end

  def render("show.json", %{story: story}) do
    %{data: render_one(story, Pepe02Api.V1.StoryView, "story.json")}
  end

  def render("story.json", %{story: story}) do
    %{id: story.id,
      title: story.title,
      content: story.content}
  end
end
