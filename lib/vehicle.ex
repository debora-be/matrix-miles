defmodule Vehicle do
  @moduledoc """
  Creates a new vehicle struct; defaults to the initial position.
  """

  defstruct x: 0, y: 0, direction: "N"

  @doc """
  Moves the vehicle one unit in the direction it is facing.
  Accepts cardinal directions: N, S, E, W (english) or N, S, L, O (portuguese).
  """
  @spec move(Struct.t) :: Struct.t
  def move(vehicle) do
    case vehicle.direction do
      "N" -> %Vehicle{vehicle | y: vehicle.y + 1}
      "S" -> %Vehicle{vehicle | y: vehicle.y - 1}
      "L" -> %Vehicle{vehicle | x: vehicle.x + 1}
      "E" -> %Vehicle{vehicle | x: vehicle.x + 1}
      "O" -> %Vehicle{vehicle | x: vehicle.x - 1}
      "W" -> %Vehicle{vehicle | x: vehicle.x - 1}
      # "M" -> %Vehicle{vehicle | y: vehicle.y + 1}
    end
  end

  @doc """
  Turns the vehicle 90 degrees to the left or right.
  """
  def turn("L", "N"), do: "W"
  def turn("L", "W"), do: "S"
  def turn("L", "S"), do: "E"
  def turn("L", "E"), do: "N"

  def turn("R", "N"), do: "E"
  def turn("R", "E"), do: "S"
  def turn("R", "S"), do: "W"
  def turn("R", "W"), do: "N"
end
