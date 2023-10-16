defmodule MatrixMiles.Factory do
  use ExMachina

  alias MatrixMiles.Vehicles.Vehicle

  def vehicle_factory do
    %Vehicle{
      x: 0,
      y: 0,
      direction: "N"
    }
  end

  def north_boundary_vehicle_factory do
    %Vehicle{
      x: 3,
      y: 5,
      direction: "N"
    }
  end

  def south_boundary_vehicle_factory do
    %Vehicle{
      x: 3,
      y: 0,
      direction: "S"
    }
  end

  def east_boundary_vehicle_factory do
    %Vehicle{
      x: 5,
      y: 3,
      direction: "E"
    }
  end

  def west_boundary_vehicle_factory do
    %Vehicle{
      x: 0,
      y: 3,
      direction: "W"
    }
  end
end
