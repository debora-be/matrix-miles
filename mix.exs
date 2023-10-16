defmodule MatrixMiles.MixProject do
  use Mix.Project

  def project do
    [
      app: :matrix_miles,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      escript: escript_config(),
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.cobertura": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:ex_machina, :logger]
    ]
  end

  defp escript_config do
    [
      main_module: MatrixMiles.CLI
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:ex_machina, "~> 2.7.0"},
      {:excoveralls, "~> 0.18", only: :test}
    ]
  end

  # This makes sure your factory and any other modules in test/support are compiled when in the test environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
