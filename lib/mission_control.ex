defmodule MissionControl do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(init_arg) do
    init_arg
  end

  def navigate(pid, initial_position, movements) do
    GenServer.call(pid, {:navigate, initial_position, movements})
  end

  def handle_call({:navigate, {x, y, direction}, movements}, _from, state) do
    vehicle = %Vehicle{x: x, y: y, direction: direction}

    final_position = Enum.reduce(movements, vehicle, fn
      "M", vehicle -> Vehicle.move(vehicle)
      turn, vehicle -> %Vehicle{vehicle | direction: Vehicle.turn(turn, vehicle.direction)}
    end)

    {:reply, final_position, state}
  end
end
