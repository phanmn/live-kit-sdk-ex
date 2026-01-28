defmodule LiveKitSdkEx.VideoGrant do
  use ExConstructor

  @moduledoc """
  VideoGrant encapsulates all the video-related grants for a LiveKit access token.
  """

  defstruct [
    :room_create,
    :room_join,
    :room_list,
    :room_record,
    :room_admin,
    :room,
    :can_publish,
    :can_publish_sources,
    :can_subscribe,
    :can_publish_data,
    :can_update_own_metadata,
    :hidden,
    :recorder,
    :ingress_admin
  ]

  @type t :: %__MODULE__{
          room_create: boolean() | nil,
          room_join: boolean() | nil,
          room_list: boolean() | nil,
          room_record: boolean() | nil,
          room_admin: boolean() | nil,
          room: String.t() | nil,
          can_publish: boolean() | nil,
          can_publish_sources: list(String.t()) | nil,
          can_subscribe: boolean() | nil,
          can_publish_data: boolean() | nil,
          can_update_own_metadata: boolean() | nil,
          hidden: boolean() | nil,
          recorder: boolean() | nil,
          ingress_admin: boolean() | nil
        }

  @doc """
  Creates a new VideoGrant instance.

  ## Options
    * `:room_create` - true if can create or delete rooms
    * `:room_join` - true if can join room
    * `:room_list` - true if can list rooms
    * `:room_record` - true if can record
    * `:room_admin` - true if can manage the room
    * `:room` - name of the room for join or admin permissions
    * `:can_publish` - for join tokens, can participant publish, true by default
    * `:can_publish_sources` - TrackSource types that a participant may publish
    * `:can_subscribe` - for join tokens, can participant subscribe, true by default
    * `:can_publish_data` - for join tokens, can participant publish data messages, true by default
    * `:can_update_own_metadata` - by default, a participant is not allowed to update its own metadata
    * `:hidden` - if participant should remain invisible to others
    * `:recorder` - if participant is recording the room
    * `:ingress_admin` - can create and manage Ingress
  """
  def new(opts \\ []) do
    super(opts)
  end

  @doc """
  Creates a VideoGrant from a map (equivalent to Ruby's from_hash).
  """
  def from_map(nil), do: nil
  def from_map(struct) when is_struct(struct, __MODULE__), do: struct
  def from_map(map) do
    new(map)
  end

  @doc """
  Converts the VideoGrant to a map for JWT encoding.
  """
  def to_map(%__MODULE__{} = grant) do
    %{}
    |> maybe_put("roomCreate", grant.room_create)
    |> maybe_put("roomJoin", grant.room_join)
    |> maybe_put("roomList", grant.room_list)
    |> maybe_put("roomRecord", grant.room_record)
    |> maybe_put("roomAdmin", grant.room_admin)
    |> maybe_put("room", grant.room)
    |> maybe_put("canPublish", grant.can_publish)
    |> maybe_put("canPublishSources", grant.can_publish_sources)
    |> maybe_put("canSubscribe", grant.can_subscribe)
    |> maybe_put("canPublishData", grant.can_publish_data)
    |> maybe_put("canUpdateOwnMetadata", grant.can_update_own_metadata)
    |> maybe_put("hidden", grant.hidden)
    |> maybe_put("recorder", grant.recorder)
    |> maybe_put("ingressAdmin", grant.ingress_admin)
  end

  defp maybe_put(map, _key, nil), do: map
  defp maybe_put(map, key, value), do: Map.put(map, key, value)
end
