defmodule PentoWeb.DemographicLive.Form do
  use PentoWeb, :live_component
  alias Pento.Survey
  alias Pento.Survey.Demographic

  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign_demographic()
      |> clear_form()
    }
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographic, %Demographic{user_id: current_user.id})
  end

  defp clear_form(%{assigns: %{demographic: demographic}} = socket) do
    assign_form(socket, Survey.change_demographic(demographic))
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
