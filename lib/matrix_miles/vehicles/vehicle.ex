defmodule MatrixMiles.Vehicles.Vehicle do
  @moduledoc """
  Creates a new vehicle struct; accepts :x and :y axis values, and a direction E, D or M.
  """
  defstruct [:x, :y, :direction]
end
