defmodule MatrixMiles.Stdins.Io do
  @moduledoc """
  Input/Output module for MatrixMiles application.
  """
  alias MatrixMiles.Vehicles.Vehicle

  @doc """
  Starts the input/output interaction.
  """
  @spec start() :: :ok
  def start do
    IO.puts("Welcome to the MatrixMiles Martian Vehicle Navigation System!")

    with {:ok, platform_size} <- get_platform_size(),
         {:ok, number_of_vehicles} <- get_number_of_vehicles(),
         {:ok, vehicle_data} <- get_vehicle_data(number_of_vehicles) do
      MatrixMiles.call(platform_size, vehicle_data)
    else
      {:error, :unexpected_end_of_input} ->
        IO.puts("Unexpected end of input. Please try again.")
        start()

      {:error, :invalid_input} ->
        IO.puts("Invalid input. Please try again.")
        start()
    end
  end

  defp get_platform_size do
    IO.puts("Enter the matrix size (for example, '5 5'):")

    case IO.gets("> ") do
      :eof -> {:error, :unexpected_end_of_input}
      input ->
        values =
          input
          |> String.split()
          |> Enum.map(&format/1)
        case values do
          [x, y] -> {:ok, {x, y}}
          _ -> {:error, :invalid_input}
        end
      end
    end

  defp get_number_of_vehicles do
    IO.puts("Enter the number of vehicles:")

    case IO.gets("> ") do
      :eof -> {:error, :unexpected_end_of_input}
      input ->
        if input > 0 do
          response =
            input
            |> String.trim()
            |> format()
          {:ok, response}
        else
          {:error, :invalid_input}
        end
      end
  end

  defp get_vehicle_data(0), do: {:ok, []}
  defp get_vehicle_data(number_of_vehicles) when number_of_vehicles > 0 do
    IO.puts("Enter vehicle's initial position (for example, '1 2 N'):")

    position_input = IO.gets("> ")

    case position_input do
      :eof -> {:error, :unexpected_end_of_input}
      position ->
        IO.puts("Enter vehicle's movements (for example, 'EMEMEMEMM'):")

        movements_input = IO.gets("> ")

        case movements_input do
          :eof -> {:error, :unexpected_end_of_input}
          movements ->
            [x, y, direction] = String.split(position)
            actual_movements = String.trim(movements)
            vehicle = %Vehicle{x: format(x), y: format(y), direction: direction}
            with {:ok, rest} <- get_vehicle_data(number_of_vehicles - 1) do
              {:ok, [{vehicle, actual_movements} | rest]}
            else
              error -> error
            end
        end
    end
  end

  defp format(data), do: String.to_integer(data)
end
