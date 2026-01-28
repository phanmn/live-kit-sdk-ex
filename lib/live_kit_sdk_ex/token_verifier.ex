defmodule LiveKitSdkEx.TokenVerifier do
  use ExConstructor

  @moduledoc """
  TokenVerifier verifies and decodes LiveKit access tokens.
  """

  defstruct [
    :api_key,
    :api_secret
  ]

  @type t :: %__MODULE__{
          api_key: String.t(),
          api_secret: String.t()
        }

  @doc """
  Creates a new TokenVerifier instance.

  ## Options
    * `:api_key` - LiveKit API key
    * `:api_secret` - LiveKit API secret

  ## Examples

      iex> TokenVerifier.new(api_key: "key", api_secret: "secret")
      %TokenVerifier{...}
  """
  def new(opts \\ []) do
    super(opts)
  end

  @doc """
  Verifies a token

  Returns `{:ok, claim_grant}` if the token is valid, or `{:error, reason}` if invalid.

  ## Examples

      iex> verifier = TokenVerifier.new(api_key: "key", api_secret: "secret")
      iex> TokenVerifier.verify(verifier, jwt_token)
      {:ok, %LiveKit.ClaimGrant{...}}
  """
  def verify(%__MODULE__{api_key: api_key, api_secret: api_secret}, token) do
    signer = Joken.Signer.create(LiveKitSdkEx.AccessToken.signing_algorithm(), api_secret)

    token
    |> Joken.verify(signer)
    |> case do
      {:ok, %{"iss" => ^api_key} = claims} ->
        {:ok, LiveKitSdkEx.ClaimGrant.from_map(claims)}

      {:ok, _} ->
        {:error, "invalid_issuer"}

      e ->
        e
    end
  end
end
