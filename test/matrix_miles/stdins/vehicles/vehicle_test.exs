defmodule MatrixMiles.Vehicles.VehicleTest do
  use ExUnit.Case
  import MatrixMiles.Factory

  test "vehicle struct creates a default vehicle correctly" do
    vehicle = build(:vehicle)
    assert vehicle.x == 0
    assert vehicle.y == 0
    assert vehicle.direction == "N"
  end

  test "vehicle struct creates another vehicle correctly" do
    vehicle = build(:vehicle, x: 9, y: 9, direction: "S")
    assert vehicle.x == 9
    assert vehicle.y == 9
    assert vehicle.direction == "S"
  end
end
