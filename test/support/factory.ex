defmodule MatrixMiles.Factory do
  use ExMachina

  def vehicle_factory do
    %MatrixMiles.Vehicles.Vehicle{
      x: 0,
      y: 0,
      direction: "N"
    }
  end
end
