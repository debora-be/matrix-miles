defmodule MatrixMiles.Stdins.IoTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias MatrixMiles.Stdins.Io

  describe "start/0" do
    test "outputs the welcome message and gets matrix size, number of vehicles, and vehicle data" do

      input = "5 5\n1\n1 2 N\nEMEMEMEMM\n"
      output = capture_io(input, fn ->
        Io.start()
      end)

      assert output =~ "Welcome to the MatrixMiles Martian Vehicle Navigation System!"
      assert output =~ "Enter the matrix size"
      assert output =~ "Enter the number of vehicles:"
      assert output =~ "Enter vehicle's initial position"
      assert output =~ "Enter vehicle's movements"
    end
  end
end
