defmodule MatrixMiles.Stdins.Io do
  @moduledoc """
  Input/Output module for MatrixMiles application.
  """
  alias MatrixMiles.Error
  alias MatrixMiles.Vehicles.Vehicle

  @doc """
  Starts the input/output interaction.
  """
  @spec start() :: :ok
  def start do
    IO.puts("Welcome to the MatrixMiles Martian Vehicle Navigation System!")

    with platform_size <- get_platform_size(),
         number_of_vehicles <- get_number_of_vehicles(),
         vehicle_data <- Enum.map(1..number_of_vehicles, fn _ ->
            get_vehicle_data()
          end) do
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

    [x, y] =
      "> "
      |> IO.gets()
      |> String.split()
      |> Enum.map(&format/1)

    {x, y}
  end

  defp get_number_of_vehicles do
    IO.puts("Enter the number of vehicles:")

    case IO.gets("> ") do
      :eof -> {:error, :unexpected_end_of_input}
      input ->
        input
        |> String.trim()
        |> format()
    end
  end


  defp get_vehicle_data do
    IO.puts("Enter vehicle's initial position (for example, '1 2 N'):")

    [x, y, direction] =
      "> "
      |> IO.gets()
      |> String.split()

    IO.puts("Enter vehicle's movements (for example, 'EMEMEMEMM'):")

    movements =
      "> "
        |> IO.gets()
        |> String.trim()

    {%Vehicle{x: format(x), y: format(y), direction: direction}, movements}
  end

  defp format(data), do: String.to_integer(data)
end
