defmodule Commander.MixProject do
  use Mix.Project

  def project do
    [
      app: :commander,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Commander.Application,[]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, ">= 0.0.0"},
      {:jason, ">= 0.0.0"},
      {:postgrex, ">= 0.0.0"}
    ]
  end
end
