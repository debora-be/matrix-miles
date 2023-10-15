defmodule MatrixMiles.CLI do
  @moduledoc """
  Command Line Interface for MatrixMiles application.
  """
  alias MatrixMiles.Stdins.Io

  def main(_args) do
    Io.start()
  end
end
