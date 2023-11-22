defmodule Pento.Game.Point do
  def new(x, y) when is_integer(x) and is_integer(y), do: {x, y}

  def move({x, y}, {change_x, change_y}) do
    {x + change_x, y + change_y}
  end

  def transpose({x, y}), do: {y, x}
  def flip({x, y}), do: {x, 6 - y}
  def reflect({x, y}), do: {6 - x, y}
end