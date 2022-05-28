defmodule Simplify.Mixfile do
  use Mix.Project

  def project do
    [
      app: :simplify,
      version: "1.0.0",
      elixir: "~> 1.6",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      dialyzer: [plt_add_apps: [:mix]],
      test_coverage: [tool: ExCoveralls],
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:geo, "~> 3.1"},
      {:distance, "~> 0.2.1"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:benchfella, "~> 0.3.0", only: :dev},
      {:jason, "~> 1.1", only: :test},
      {:excoveralls, "~> 0.4", only: :test},
      {:credo, "~> 1.6", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Implementation of the Ramer–Douglas–Peucker algorithm for reducing the number of points used to represent a curve.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Powell Kinney"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/pkinney/simplify_ex"}
    ]
  end

  defp aliases do
    [
      validate: [
        "clean",
        "compile --warnings-as-error",
        "format --check-formatted",
        "credo",
        "dialyzer"
      ]
    ]
  end
end
