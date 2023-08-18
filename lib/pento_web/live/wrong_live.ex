defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, session, socket) do
    {:ok,
     assign(socket,
       score: 0,
       message: "Make a guess.",
       answer: Enum.random(1..10),
       session_id: session["live_socket_id"]
     )}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>

    <h2>
      <p>
        <%= @message %>
      </p>
      <p>It's time <%= time() %></p>
      <p>Answer: <%= @answer %></p>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number={n}>
          <%= n %>
        </.link>
      <% end %>
      <pre>
        <%= @current_user.email %>
        <%= @session_id %>
      </pre>
    </h2>
    """
  end

  def time() do
    DateTime.utc_now() |> to_string()
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    if socket.assigns.answer == String.to_integer(guess) do
      score = socket.assigns.score + 1
      message = "Your win with #{guess}!"

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score
        )
      }
    else
      score = socket.assigns.score - 1
      message = "Your guess: #{guess}. Wrong. Guess again."

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score
        )
      }
    end
  end
end
