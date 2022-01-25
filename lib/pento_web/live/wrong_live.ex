defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Guess a number.",
        random_number: Enum.random(1..10)
      )
    }
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    score = socket.assigns.score - 1
    {
      :noreply,
      assign(
        socket,
        message: message(guess, socket),
        score: score
      )
    }
  end

  def render(assigns) do
    ~L"""
    <h2>Random number to guess: <%= @random_number %></h2>
    <h1>Your score: <%= @score %></h1>
    <p>
      <h2>
        <%= @message %> It's <%= time() %>
      </h2>
    </p>

    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
      <% end %>
    </h2>
    <p>
    </p>
    """
  end

  defp time do
    DateTime.utc_now |> to_string
  end

  defp message(guess, socket) do
    message = "Your guess: #{guess}."

    if String.to_integer(guess) == socket.assigns.random_number do
      message <> "Well done!"
    else
      message <> "Wrong. Guess again."
    end
  end
end
