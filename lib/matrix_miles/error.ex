defmodule MatrixMiles.Error do
  @moduledoc """
  Error struct
  """

  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end

  def build_north_boundary_error, do: build(:boundary_error, "Vehicle at North boundary, can't move North")
  def build_south_boundary_error, do: build(:boundary_error, "Vehicle at South boundary, can't move South")
  def build_east_boundary_error, do: build(:boundary_error, "Vehicle at East boundary, can't move East")
  def build_west_boundary_error, do: build(:boundary_error, "Vehicle at West boundary, can't move West")
  def build_invalid_movement_direction_error, do: build(:invalid_direction, "Invalid movement direction")
end
