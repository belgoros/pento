defmodule PentoWeb.SurveyLive.Component do
  use Phoenix.Component

  attr :content, :string, required: true
  slot :inner_block, required: true

  def hero(assigns) do
    ~H"""
    <h1 class="text-3xl font-heavy">
      <%= @content %>
    </h1>
    <h3>
      <%= render_slot(@inner_block) %>
    </h3>
    """
  end
end
