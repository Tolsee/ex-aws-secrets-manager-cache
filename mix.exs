defmodule ExAwsSecretsManagerCache.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aws_secrets_manager_cache,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExAwsSecretsManagerCache.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_aws, "~> 2.1"},
      {:ex_aws_secretsmanager, "~> 2.0"},
      {:hackney, "~> 1.9"},
      {:jason, "~> 1.1"},
      {:mimic, "~> 1.2", only: :test}
    ]
  end
end
