defmodule MatrixMiles.Vehicles.VehicleNavigationTest do
  use ExUnit.Case
  import MatrixMiles.Factory

  alias MatrixMiles.Error
  alias MatrixMiles.Vehicles.VehicleNavigation

  describe "turn/2" do
    test "turns the vehicle correctly" do
      # Testing every combination from the turns map
      assert VehicleNavigation.turn("E", "N") == "O"
      assert VehicleNavigation.turn("E", "O") == "S"
      assert VehicleNavigation.turn("E", "S") == "L"
      assert VehicleNavigation.turn("E", "L") == "N"

      assert VehicleNavigation.turn("L", "N") == "W"
      assert VehicleNavigation.turn("L", "W") == "S"
      assert VehicleNavigation.turn("L", "S") == "E"
      assert VehicleNavigation.turn("L", "E") == "N"

      assert VehicleNavigation.turn("D", "N") == "L"
      assert VehicleNavigation.turn("D", "L") == "S"
      assert VehicleNavigation.turn("D", "S") == "O"
      assert VehicleNavigation.turn("D", "O") == "N"

      assert VehicleNavigation.turn("R", "N") == "E"
      assert VehicleNavigation.turn("R", "E") == "S"
      assert VehicleNavigation.turn("R", "S") == "W"
      assert VehicleNavigation.turn("R", "W") == "N"
    end

    test "returns error when passed a nil or empty direction" do
      assert VehicleNavigation.turn(nil, "N") == %Error{status: :invalid_direction, result: "Invalid turn or current direction"}
      assert VehicleNavigation.turn("", "N") == %Error{status: :invalid_direction, result: "Invalid turn or current direction"}
    end

    test "returns error for invalid turn directions" do
      directions = ["N", "S", "E", "W", "L", "O"]
      directions |> Enum.each(fn direction ->
        assert VehicleNavigation.turn("Z", direction) == %Error{status: :invalid_direction, result: "Invalid turn or current direction"}
      end)
    end
  end

  describe "move/2" do
    test "moves the vehicle correctly based on its direction and doesn't cross the matrix boundaries" do
      boundary = {5, 5}

      # Moving North
      assert VehicleNavigation.move(build(:vehicle, x: 3, y: 3, direction: "N"), boundary).y == 4

      # Here, the vehicle tries to move North when it's already at the North boundary
      assert VehicleNavigation.move(build(:vehicle, x: 3, y: 5, direction: "N"), boundary) == %MatrixMiles.Error{
        status: :boundary_error,
        result: "Vehicle at North boundary, can't move North"
      }

      # Moving South
      assert VehicleNavigation.move(build(:vehicle, x: 3, y: 3, direction: "S"), boundary).y == 2

      # Here, the vehicle tries to move South when it's already at the South boundary
      assert VehicleNavigation.move(build(:vehicle, x: 3, y: 0, direction: "S"), boundary) == %MatrixMiles.Error{
        status: :boundary_error,
        result: "Vehicle at South boundary, can't move South"
      }

      # Moving East
      assert VehicleNavigation.move(build(:vehicle, x: 3, y: 3, direction: "E"), boundary).x == 4

      # Here, the vehicle tries to move East when it's already at the East boundary
      assert VehicleNavigation.move(build(:vehicle, x: 5, y: 3, direction: "E"), boundary) == %MatrixMiles.Error{
        status: :boundary_error,
        result: "Vehicle at East boundary, can't move East"
      }

      # Moving West
      assert VehicleNavigation.move(build(:vehicle, x: 3, y: 3, direction: "W"), boundary).x == 2

      # Here, the vehicle tries to move West when it's already at the West boundary
      assert VehicleNavigation.move(build(:vehicle, x: 0, y: 3, direction: "W"), boundary) == %MatrixMiles.Error{
        status: :boundary_error,
        result: "Vehicle at West boundary, can't move West"
      }

      # Moving Leste (Portuguese East)
      assert VehicleNavigation.move(build(:vehicle, x: 3, y: 3, direction: "L"), boundary).x == 4

      # Here, the vehicle tries to move Leste (East) when it's already at the East boundary
      assert VehicleNavigation.move(build(:vehicle, x: 5, y: 3, direction: "L"), boundary) == %MatrixMiles.Error{
        status: :boundary_error,
        result: "Vehicle at East boundary, can't move East"
      }

      # Moving Oeste (Portuguese West)
      assert VehicleNavigation.move(build(:vehicle, x: 3, y: 3, direction: "O"), boundary).x == 2

      # Here, the vehicle tries to move Oeste (West) when it's already at the West boundary
      assert VehicleNavigation.move(build(:vehicle, x: 0, y: 3, direction: "O"), boundary) == %MatrixMiles.Error{
        status: :boundary_error,
        result: "Vehicle at West boundary, can't move West"
      }
    end

    test "returns error when vehicle tries to cross boundaries" do
      boundary = {5, 5}

      assert VehicleNavigation.move(build(:vehicle, x: 3, y: 5, direction: "N"), boundary) == %Error{result: "Vehicle at North boundary, can't move North", status: :boundary_error}
      assert VehicleNavigation.move(build(:vehicle, x: 3, y: 0, direction: "S"), boundary) == %Error{result: "Vehicle at South boundary, can't move South", status: :boundary_error}
      assert VehicleNavigation.move(build(:vehicle, x: 5, y: 3, direction: "E"), boundary) == %Error{result: "Vehicle at East boundary, can't move East", status: :boundary_error}
      assert VehicleNavigation.move(build(:vehicle, x: 0, y: 3, direction: "W"), boundary) == %Error{result: "Vehicle at West boundary, can't move West", status: :boundary_error}
      assert VehicleNavigation.move(build(:vehicle, x: 5, y: 3, direction: "L"), boundary) == %Error{result: "Vehicle at East boundary, can't move East", status: :boundary_error}
      assert VehicleNavigation.move(build(:vehicle, x: 0, y: 3, direction: "O"), boundary) == %Error{result: "Vehicle at West boundary, can't move West", status: :boundary_error}
    end

    test "returns error for invalid movement directions" do
      vehicle = build(:vehicle, x: 3, y: 3, direction: "Z")
      assert VehicleNavigation.move(vehicle, {5, 5}) == %Error{status: :invalid_direction, result: "Invalid movement direction"}
    end
  end
end
