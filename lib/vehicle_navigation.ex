defmodule VehicleNavigation do
  @moduledoc """
  Controls the vehicle's movements and directions on the Martian terrain.
  """

  @turns %{
    {"E", "N"} => "O",
    {"E", "O"} => "S",
    {"E", "S"} => "L",
    {"E", "L"} => "N",

    {"L", "N"} => "W",
    {"L", "W"} => "S",
    {"L", "S"} => "E",
    {"L", "E"} => "N",

    {"D", "N"} => "L",
    {"D", "L"} => "S",
    {"D", "S"} => "O",
    {"D", "O"} => "N",

    {"R", "N"} => "E",
    {"R", "E"} => "S",
    {"R", "S"} => "W",
    {"R", "W"} => "N"
  }

  @spec turn(String.t(), String.t()) :: String.t()
  def turn(direction, current_direction) do
    Map.get(@turns, {direction, current_direction}, current_direction)
  end

  @doc """
  Moves the vehicle one unit in the direction it is facing.
  Accepts cardinal directions: N, S, E, W (english) or N, S, L, O (portuguese).
  """
  @spec move(Vehicle.t(), {integer, integer}) :: Vehicle.t()
  def move(%Vehicle{x: x, y: y, direction: direction} = vehicle, {max_x, max_y}) do
    case {direction, x, y} do
      {"N", _, y} when y < max_y -> %Vehicle{vehicle | y: y + 1}
      {"S", _, y} when y > 0 -> %Vehicle{vehicle | y: y - 1}
      {"L", x, _} when x < max_x -> %Vehicle{vehicle | x: x + 1}
      {"E", x, _} when x < max_x -> %Vehicle{vehicle | x: x + 1}
      {"O", x, _} when x > 0 -> %Vehicle{vehicle | x: x - 1}
      {"W", x, _} when x > 0 -> %Vehicle{vehicle | x: x - 1}
      _ -> vehicle
    end
  end
end
