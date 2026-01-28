defmodule LiveKitSdkEx.SIPGrant do
  use ExConstructor
  @moduledoc """
  SIPGrant encapsulates all the SIP-related grants for a LiveKit access token.
  """

  defstruct [
    :admin,
    :call
  ]

  @type t :: %__MODULE__{
          admin: boolean() | nil,
          call: boolean() | nil
        }

  @doc """
  Creates a new SIPGrant instance.

  ## Options
    * `:admin` - true if can access SIP features
    * `:call` - true if can make outgoing call
  """
  def new(opts \\ []) do
    super(opts)
  end

  @doc """
  Creates a SIPGrant from a map (equivalent to Ruby's from_hash).
  """
  def from_map(nil), do: nil
  def from_map(struct) when is_struct(struct, __MODULE__), do: struct
  def from_map(map) when is_map(map) do
    new(map)
  end

  @doc """
  Converts the SIPGrant to a map for JWT encoding.
  """
  def to_map(%__MODULE__{} = grant) do
    %{}
    |> maybe_put("admin", grant.admin)
    |> maybe_put("call", grant.call)
  end

  defp maybe_put(map, _key, nil), do: map
  defp maybe_put(map, key, value), do: Map.put(map, key, value)
end
