defmodule ExAwsSecretsManagerCache.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: ExAwsSecretsManagerCache.Worker.start_link(arg)
      # {ExAwsSecretsManagerCache.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExAwsSecretsManagerCache.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
