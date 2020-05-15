# ExAwsSecretsManagerCache

ExAwsSecretsManagerCache provides a caching mechanism for secrets from AWS secrets manager. It is based in [AWS guides](https://docs.aws.amazon.com/secretsmanager/latest/userguide/use-client-side-caching.html).

## Installation

This package can be installed by adding `ex_aws_secrets_manager_cache` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_aws_secrets_manager_cache, github: "Tolsee/ex-aws-secrets-manager-cache"}
  ]
end
```

