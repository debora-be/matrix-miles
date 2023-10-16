defmodule MatrixMiles do
  @moduledoc """
  Main module to handle navigation of vehicles on the Martian terrain.
  """
  alias MatrixMiles.Vehicles.{Vehicle, VehicleNavigation}

  @doc """
  Given the size of the platform and a list of vehicles with their initial positions and movements, returns the final position of each vehicle.
  """
  @spec call({integer, integer}, list({{integer, integer, String.t()}, String.t()})) :: :ok
  def call(platform_size, vehicle_data) do
    vehicle_data
    |> Enum.map(&navigate_vehicle(&1, platform_size))
    |> Enum.each(&print_vehicle_position/1)

    :ok
  end

  @doc """
  Given the initial position of a vehicle and a list of movements, returns the final position of the vehicle.
  """
  @spec navigate_vehicle({Vehicle.t(), String.t()}, {integer, integer}) :: Vehicle.t()
  def navigate_vehicle({%Vehicle{} = vehicle, movements}, platform_size) do
    movements
    |> clear_movements()
    |> Enum.reduce_while(vehicle, fn
      "M", veh ->
        case VehicleNavigation.move(veh, platform_size) do
          {:error, error_msg} ->
            IO.puts(error_msg)
            {:halt, veh}
          veh -> {:cont, veh}
        end

      turn, veh -> {:cont, %Vehicle{veh | direction: VehicleNavigation.turn(turn, veh.direction)}}
    end)
  end

  defp print_vehicle_position(%Vehicle{x: x, y: y, direction: direction}) do
    IO.puts("#{x} #{y} #{direction}")
  end

  defp clear_movements(movements), do: String.graphemes(movements)
end
