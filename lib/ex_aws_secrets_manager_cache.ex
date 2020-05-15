defmodule ExAwsSecretsManagerCache do
  @moduledoc """
  `ExAwsSecretsManagerCache`

  It provides common utility functions to interact with Aws Secrets Manager
  """

  @doc """
  Returns secrets value
  """
  @spec get_secret(String.t()) :: {:ok, String.t()} | {:error, :not_found}
  def get_secret(name) do
    "#{name}value"
  end
end
