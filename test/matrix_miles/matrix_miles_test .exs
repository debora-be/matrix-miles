defmodule MatrixMilesTest do
  use ExUnit.Case
  import MatrixMiles.Factory

  alias MatrixMiles.Vehicles.Vehicle
  alias MatrixMiles.Vehicles.VehicleNavigation

  describe "call/2" do
    test "prints the expected final position of the vehicles" do
      platform_size = {5, 5}
      vehicle_data = [
        {build(:vehicle, x: 1, y: 2, direction: "N"), "MEMEMEMM"},
        {build(:vehicle, x: 3, y: 3, direction: "E"), "MEMEMEMM"}
      ]

      output = capture_io(fn ->
        MatrixMiles.call(platform_size, vehicle_data)
      end)

      assert output =~ "2 4 N"
      assert output =~ "5 5 E"
    end
  end

  describe "navigate_vehicle/2" do
    test "returns the expected final position for a series of movements" do
      platform_size = {5, 5}
      vehicle = build(:vehicle, x: 1, y: 2, direction: "N")
      movements = "MEMEMEMM"

      result = MatrixMiles.navigate_vehicle({vehicle, movements}, platform_size)
      assert result == %Vehicle{x: 2, y: 4, direction: "N"}
    end

    test "returns the expected final position when hitting boundaries" do
      platform_size = {5, 5}
      vehicle = build(:north_boundary_vehicle)
      movements = "MM"

      result = MatrixMiles.navigate_vehicle({vehicle, movements}, platform_size)
      assert result == %Vehicle{x: 3, y: 5, direction: "N"}
    end

    test "returns the expected final position for a series of turns and movements" do
      platform_size = {5, 5}
      vehicle = build(:vehicle, x: 3, y: 3, direction: "E")
      movements = "MEMEMEMM"

      result = MatrixMiles.navigate_vehicle({vehicle, movements}, platform_size)
      assert result == %Vehicle{x: 5, y: 5, direction: "E"}
    end

    test "handles error when an invalid movement command is given" do
      platform_size = {5, 5}
      vehicle = build(:vehicle, x: 3, y: 3, direction: "E")
      movements = "ZMEMEMEMM"

      output = capture_io(fn ->
        MatrixMiles.navigate_vehicle({vehicle, movements}, platform_size)
      end)

      assert output =~ "Invalid movement direction"
    end

    test "handles error when hitting North boundary and can't move North" do
      platform_size = {5, 5}
      movements = "M"

      output = capture_io(fn ->
        MatrixMiles.navigate_vehicle({build(:north_boundary_vehicle), movements}, platform_size)
      end)

      assert output =~ "Vehicle at North boundary, can't move North"
    end

    test "handles error when hitting South boundary and can't move South" do
      platform_size = {5, 5}
      movements = "M"

      output = capture_io(fn ->
        MatrixMiles.navigate_vehicle({build(:south_boundary_vehicle), movements}, platform_size)
      end)

      assert output =~ "Vehicle at South boundary, can't move South"
    end

    test "handles error when hitting East boundary and can't move East" do
      platform_size = {5, 5}
      movements = "M"

      output = capture_io(fn ->
        MatrixMiles.navigate_vehicle({build(:east_boundary_vehicle), movements}, platform_size)
      end)

      assert output =~ "Vehicle at East boundary, can't move East"
    end

    test "handles error when hitting West boundary and can't move West" do
      platform_size = {5, 5}
      movements = "M"

      output = capture_io(fn ->
        MatrixMiles.navigate_vehicle({build(:west_boundary_vehicle), movements}, platform_size)
      end)

      assert output =~ "Vehicle at West boundary, can't move West"
    end
  end
end
