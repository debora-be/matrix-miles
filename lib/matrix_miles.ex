defmodule MatrixMiles do
  def navigate(pid, start_position, movements) do
    MissionControl.navigate(pid, start_position, movements)
  end

  def start_and_navigate(platform_size, vehicle_positions, _commands) do
    {:ok, pid} = MissionControl.start_link(platform_size)

    results = Enum.map(vehicle_positions, fn {position, command} ->
      navigate(pid, position, String.split(command, "", trim: true))
    end)

    Enum.each(results, fn %Vehicle{x: x, y: y, direction: direction} ->
      IO.puts("#{x} #{y} #{direction}")
    end)
  end
end
