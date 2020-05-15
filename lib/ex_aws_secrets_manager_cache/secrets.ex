defmodule ExAwsSecretsManagerCache.Secrets do
  require Logger

  @type secret :: %{name: String.t(), value: String.t()}

  @doc """
  Returns latest version of secret
  """
  @spec get_secret(String.t()) ::
          {:ok, secret()}
          | {:error, :not_found}
          | {:error, :client_error}
  def get_secret(name) do
    name
    |> ExAws.SecretsManager.get_secret_value()
    |> ExAws.request()
    |> handle_response()
  end

  defp handle_response({:ok, %{"Name" => name, "SecretString" => value}}),
    do: {:ok, %{name: name, value: value}}

  defp handle_response(
         {:error,
          {
            :http_error,
            400,
            %{"__type" => "UnrecognizedClientException", "message" => message}
          }}
       ) do
    Logger.error("Error while fetching secret: " <> message)
    {:error, :client_error}
  end

  defp handle_response({:error, {:http_error, status, response}}) do
    Logger.warn("Could not fetch secret status: #{status} response: " <> inspect(response))
    {:error, :not_found}
  end
end
