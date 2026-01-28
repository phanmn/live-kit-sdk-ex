defmodule LiveKitSdkEx.AccessToken do
  @moduledoc """
  LiveKit AccessToken for generating JWT tokens to authenticate with LiveKit server.
  """

  # 10 minutes in seconds; how long the access token to the server is good for
  @default_ttl 600

  # The signing algorithm used by the Joken library
  @signing_algorithm "HS256"

  defstruct [
    :api_key,
    :api_secret,
    :identity,
    :ttl,
    :grants
  ]

  @type t :: %__MODULE__{
          api_key: String.t(),
          api_secret: String.t(),
          identity: String.t() | nil,
          ttl: integer(),
          grants: LiveKitSdkEx.ClaimGrant.t()
        }

  @doc """
  Returns the signing algorithm used for JWT encoding.
  """
  def signing_algorithm, do: @signing_algorithm

  @doc """
  Creates a new AccessToken instance.

  ## Options
    * `:api_key` - LiveKit API key (defaults to LIVEKIT_API_KEY env var)
    * `:api_secret` - LiveKit API secret (defaults to LIVEKIT_API_SECRET env var)
    * `:identity` - Participant identity
    * `:ttl` - Time to live in seconds (defaults to #{@default_ttl})
    * `:name` - Participant name
    * `:metadata` - Participant metadata
    * `:attributes` - Participant attributes

  ## Examples

      iex> AccessToken.new(api_key: "key", api_secret: "secret", identity: "user123")
      %AccessToken{...}
  """
  def new(opts \\ []) do
    api_key = Keyword.get(opts, :api_key) || System.get_env("LIVEKIT_API_KEY")
    api_secret = Keyword.get(opts, :api_secret) || System.get_env("LIVEKIT_API_SECRET")
    identity = Keyword.get(opts, :identity)
    ttl = Keyword.get(opts, :ttl, @default_ttl)

    %__MODULE__{
      api_key: api_key,
      api_secret: api_secret,
      identity: identity,
      ttl: ttl,
      grants: LiveKitSdkEx.ClaimGrant.new(opts)
    }
  end

  @doc """
  Sets the video grant for the token.
  """
  def set_video_grant(
        %__MODULE__{grants: grants} = token,
        %LiveKitSdkEx.VideoGrant{} = video_grant
      ) do
    %{token | grants: LiveKitSdkEx.ClaimGrant.set_video(grants, video_grant)}
  end

  @doc """
  Sets the SIP grant for the token.
  """
  def set_sip_grant(%__MODULE__{grants: grants} = token, %LiveKitSdkEx.SIPGrant{} = sip_grant) do
    %{token | grants: LiveKitSdkEx.ClaimGrant.set_sip(grants, sip_grant)}
  end

  @doc """
  Sets the participant metadata.
  """
  def set_metadata(%__MODULE__{grants: grants} = token, metadata) do
    %{token | grants: LiveKitSdkEx.ClaimGrant.set_metadata(grants, metadata)}
  end

  @doc """
  Sets the participant attributes.
  """
  def set_attributes(%__MODULE__{grants: grants} = token, attributes) do
    %{token | grants: LiveKitSdkEx.ClaimGrant.set_attributes(grants, attributes)}
  end

  @doc """
  Sets the participant name.
  """
  def set_name(%__MODULE__{grants: grants} = token, name) do
    %{token | grants: LiveKitSdkEx.ClaimGrant.set_name(grants, name)}
  end

  @doc """
  Gets the SHA256 value.
  """
  def get_sha256(%__MODULE__{grants: grants}) do
    LiveKitSdkEx.ClaimGrant.get_sha256(grants)
  end

  @doc """
  Sets the SHA256 value.
  """
  def set_sha256(%__MODULE__{grants: grants} = token, sha_string) do
    %{token | grants: LiveKitSdkEx.ClaimGrant.set_sha256(grants, sha_string)}
  end

  @doc """
  Sets the room configuration.
  """
  def set_room_config(%__MODULE__{grants: grants} = token, room_config) do
    %{token | grants: LiveKitSdkEx.ClaimGrant.set_room_config(grants, room_config)}
  end

  @doc """
  Sets the room preset.
  """
  def set_room_preset(%__MODULE__{grants: grants} = token, room_preset) do
    %{token | grants: LiveKitSdkEx.ClaimGrant.set_room_preset(grants, room_preset)}
  end

  @doc """
  Generates a JWT token string.

  ## Examples

      iex> token = AccessToken.new(api_key: "key", api_secret: "secret", identity: "user123")
      iex> token = AccessToken.set_video_grant(token, %VideoGrant{room_join: true, room: "my-room"})
      iex> AccessToken.to_jwt(token)
      {:ok, "eyJhbGc..."}
  """
  def to_jwt(%__MODULE__{grants: %{video: video, sip: sip}}) when is_nil(video) or is_nil(sip) do
    {:error, "VideoGrant or SIPGrant is required"}
  end

  def to_jwt(%__MODULE__{
        grants: grants,
        api_key: api_key,
        api_secret: api_secret,
        identity: identity,
        ttl: ttl
      }) do
    jwt_timestamp = System.system_time(:second)

    payload =
      grants
      |> LiveKitSdkEx.ClaimGrant.to_map()
      |> Map.merge(%{
        "exp" => jwt_timestamp + ttl,
        "nbf" => jwt_timestamp - 5,
        "iss" => api_key,
        "sub" => identity
      })
      |> reject_nil_values()

    signer = Joken.Signer.create(@signing_algorithm, api_secret)

    case Joken.encode_and_sign(payload, signer) do
      {:ok, token, _claims} -> {:ok, token}
      {:error, reason} -> {:error, reason}
    end
  end

  # Helper function to remove nil values from the map
  defp reject_nil_values(map) do
    map
    |> Enum.reject(fn {_k, v} -> is_nil(v) end)
    |> Map.new()
  end
end
