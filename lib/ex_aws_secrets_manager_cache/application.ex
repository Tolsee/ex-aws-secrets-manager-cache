defmodule ExAwsSecretsManagerCache.Application do
  @moduledoc """
  ExAwsSecretsManagerCache.Application
  
  It is stand alone application, which starts supervised process for ExAwsSecretsManagerCache.
  """

  use Application

  @spec start(any(), any()) :: {:error, any()} | {:ok, pid}
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: ExAwsSecretsManagerCache.Worker.start_link(arg)
      # {ExAwsSecretsManagerCache.Worker, arg}
    ]

    opts = [strategy: :one_for_one, name: ExAwsSecretsManagerCache.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
