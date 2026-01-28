defmodule LiveKitSdkEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :live_kit_sdk_ex,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:joken, "~> 2.6"},
      {:exconstructor, "~> 1.2"},
      {:live_kit_protocol_ex, git: "git@github.com:phanmn/livekit-protocol-ex.git", branch: "main"},
      {:recase, "~> 0.5"}
    ]
  end
end
