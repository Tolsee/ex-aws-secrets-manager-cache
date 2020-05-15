defmodule ExAwsSecretsManagerCacheTest do
  use ExUnit.Case

  describe "get_secret/1" do
    test "returns secret value" do
      assert ExAwsSecretsManagerCache.get_secret("secret") == "secretvalue"
    end
  end
end
