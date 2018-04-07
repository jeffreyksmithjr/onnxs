defmodule ONNXS.MixProject do
  use Mix.Project

  def project do
    [
      app: :onnxs,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: "ONNX interop for Elixir",
      package: package,
      deps: deps()
    ]
  end

  def package do
    [
      name: :onnxs,
      files: ["lib", "mix.exs"],
      maintainers: ["Jeff Smith"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/jeffreyksmithjr/onnxs"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:protobuf, "~> 0.5.3"}
    ]
  end
end
