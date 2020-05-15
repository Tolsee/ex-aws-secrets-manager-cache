defmodule ExAwsSecretsManagerCache.SecretsTest do
  use ExUnit.Case
  use Mimic

  import ExUnit.CaptureLog

  describe "get_secret/1" do
    test "returns {:ok, secret} when secret fetched successfully" do
      secret_name = "test/token"

      expect(ExAws, :request, fn _ ->
        {:ok,
         %{
           "ARN" => "arn:aws:secretsmanager:us-east-1:674234859779:secret:test/token-XKtBu7",
           "CreatedDate" => 1_589_517_162.39,
           "Name" => secret_name,
           "SecretString" => "abc123",
           "VersionId" => "8f1d107b-e65e-4217-9514-5e478bb96055",
           "VersionStages" => ["AWSCURRENT"]
         }}
      end)

      assert {:ok, %{name: ^secret_name, value: "abc123"}} =
               ExAwsSecretsManagerCache.Secrets.get_secret("test/token")

      verify!()
    end

    test "returns {:error, :client_error} and logs error properly when AWS key are invalid" do
      expect(ExAws, :request, fn _ ->
        {:error,
         {:http_error, 400,
          %{
            "__type" => "UnrecognizedClientException",
            "message" => "The security token included in the request is invalid."
          }}}
      end)

      assert capture_log([level: :error], fn ->
               assert {:error, :client_error} =
                        ExAwsSecretsManagerCache.Secrets.get_secret("test/token")
             end) =~
               "Error while fetching secret: The security token included in the request is invalid."

      verify!()
    end

    test "returns {:error, :not_found} and logs warning properly when secrets are not found" do
      status = 400

      response = %{
        body:
          "{\"__type\":\"ResourceNotFoundException\",\"Message\":\"Secrets Manager can't find the specified secret.\"}",
        headers: [
          {"Date", "Fri, 15 May 2020 04:45:13 GMT"},
          {"Content-Type", "application/x-amz-json-1.1"},
          {"Content-Length", "99"},
          {"Connection", "keep-alive"},
          {"x-amzn-RequestId", "3efb3aad-961c-4d44-a2bb-158d33e27f7c"}
        ],
        status_code: 400
      }

      expect(ExAws, :request, fn _ ->
        {:error, {:http_error, status, response}}
      end)

      assert capture_log([level: :warn], fn ->
               assert {:error, :not_found} =
                        ExAwsSecretsManagerCache.Secrets.get_secret("test/token")
             end) =~ "Could not fetch secret status: #{status} response: #{inspect(response)}"

      verify!()
    end
  end
end
