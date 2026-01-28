defmodule LiveKitSdkEx.ClaimGrant do
  use ExConstructor

  @moduledoc """
  ClaimGrant holds the claims/grants for a LiveKit access token.
  """

  defstruct [
    :identity,
    :name,
    :metadata,
    :sha256,
    :video,
    :sip,
    :attributes,
    :room_preset,
    :room_config
  ]

  @type t :: %__MODULE__{
          identity: String.t() | nil,
          name: String.t() | nil,
          metadata: String.t() | nil,
          sha256: String.t() | nil,
          video: LiveKitSdkEx.VideoGrant.t() | nil,
          sip: LiveKitSdkEx.SIPGrant.t() | nil,
          attributes: map() | nil,
          room_preset: String.t() | nil,
          room_config: map() | nil
        }

  @doc """
  Creates a new ClaimGrant instance.
  """
  def new(opts \\ []) do
    super(opts)
  end

  @doc """
  Creates a ClaimGrant from a map (equivalent to Ruby's from_hash).
  """
  def from_map(nil), do: nil

  def from_map(map) when is_map(map) do
    map
    |> new()
    |> case do
      struct = %{video: video, sip: sip} ->
        %{
          struct
          | video: LiveKitSdkEx.VideoGrant.from_map(video),
            sip: LiveKitSdkEx.SIPGrant.from_map(sip)
        }
    end
  end

  @doc """
  Sets the video grant.
  """
  def set_video(%__MODULE__{} = grant, video) do
    %{grant | video: video}
  end

  @doc """
  Sets the SIP grant.
  """
  def set_sip(%__MODULE__{} = grant, sip) do
    %{grant | sip: sip}
  end

  @doc """
  Sets the participant name.
  """
  def set_name(%__MODULE__{} = grant, name) do
    %{grant | name: name}
  end

  @doc """
  Sets the participant metadata.
  """
  def set_metadata(%__MODULE__{} = grant, metadata) do
    %{grant | metadata: metadata}
  end

  @doc """
  Sets the participant attributes.
  """
  def set_attributes(%__MODULE__{} = grant, attributes) do
    %{grant | attributes: attributes}
  end

  @doc """
  Gets the SHA256 value.
  """
  def get_sha256(%__MODULE__{sha256: sha256}) do
    sha256
  end

  @doc """
  Sets the SHA256 value.
  """
  def set_sha256(%__MODULE__{} = grant, sha_string) do
    %{grant | sha256: sha_string}
  end

  @doc """
  Sets the room configuration.
  """
  def set_room_config(%__MODULE__{} = grant, room_config) do
    %{grant | room_config: room_config}
  end

  @doc """
  Sets the room preset.
  """
  def set_room_preset(%__MODULE__{} = grant, room_preset) do
    %{grant | room_preset: room_preset}
  end

  @doc """
  Converts the ClaimGrant to a map for JWT encoding.
  """
  def to_map(%__MODULE__{} = grant) do
    %{}
    |> maybe_put("video", grant.video, &LiveKitSdkEx.VideoGrant.to_map/1)
    |> maybe_put("sip", grant.sip, &LiveKitSdkEx.SIPGrant.to_map/1)
    |> maybe_put("name", grant.name)
    |> maybe_put("metadata", grant.metadata)
    |> maybe_put("attributes", grant.attributes)
    |> maybe_put("sha256", grant.sha256)
    |> maybe_put("roomConfig", grant.room_config)
    |> maybe_put("roomPreset", grant.room_preset)
  end

  defp maybe_put(map, _key, nil), do: map

  defp maybe_put(map, key, value) do
    Map.put(map, key, value)
  end

  defp maybe_put(map, _key, nil, _transform), do: map

  defp maybe_put(map, key, value, transform) when is_function(transform, 1) do
    Map.put(map, key, transform.(value))
  end
end
