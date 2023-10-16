defmodule MatrixMiles.Vehicles.VehicleNavigation do
  @moduledoc """
  Controls the vehicle's movements and directions on the Martian terrain.
  """
  alias MatrixMiles.Vehicles.Vehicle

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

  def turn(nil, _current_direction), do: {:error, "Invalid direction"}
  def turn("", _current_direction), do: {:error, "Invalid direction"}
  def turn(direction, current_direction) when is_binary(direction) and is_binary(current_direction) do
    Map.get(@turns, {direction, current_direction}, {:error, "Invalid direction"})
  end


  @doc """
  Moves the vehicle one unit in the direction it is facing.
  Accepts cardinal directions: N, S, E, W (english) or N, S, L, O (portuguese).
  """
  @spec move(Vehicle.t(), {integer, integer}) :: Vehicle.t() | {:error, String.t()}
  def move(%Vehicle{x: x, y: y, direction: direction} = vehicle, {max_x, max_y}) do
    case {direction, x, y} do
      {"N", _, y} when y < max_y -> %Vehicle{vehicle | y: y + 1}
      {"S", _, y} when y > 0 -> %Vehicle{vehicle | y: y - 1}
      {"L", x, _} when x < max_x -> %Vehicle{vehicle | x: x + 1}
      {"E", x, _} when x < max_x -> %Vehicle{vehicle | x: x + 1}
      {"O", x, _} when x > 0 -> %Vehicle{vehicle | x: x - 1}
      {"W", x, _} when x > 0 -> %Vehicle{vehicle | x: x - 1}
      {"N", _, y} when y == max_y -> {:error, "Vehicle at North boundary, can't move North"}
      {"S", _, y} when y == 0 -> {:error, "Vehicle at South boundary, can't move South"}
      {"L", x, _} when x == max_x -> {:error, "Vehicle at East boundary, can't move East"}
      {"E", x, _} when x == max_x -> {:error, "Vehicle at East boundary, can't move East"}
      {"O", x, _} when x == 0 -> {:error, "Vehicle at West boundary, can't move West"}
      {"W", x, _} when x == 0 -> {:error, "Vehicle at West boundary, can't move West"}
      _ -> {:error, "Invalid movement direction"}
    end
  end
end
