defmodule MatrixMiles.CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias MatrixMiles.CLI

  describe "main/1" do
    test "calls the MatrixMiles.Stdins.Io.start/0 function" do
      input = "5 5\n1\n1 2 N\nEMEMEMEMM\n"
      output = capture_io(input, fn ->
        CLI.main([])
      end)

      assert output =~ "Welcome to the MatrixMiles Martian Vehicle Navigation System!"
      assert output =~ "Enter the matrix size"
      assert output =~ "Enter the number of vehicles:"
      assert output =~ "Enter vehicle's initial position"
      assert output =~ "Enter vehicle's movements"
    end
  end
end
