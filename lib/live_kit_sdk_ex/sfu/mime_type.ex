defmodule LiveKitSdkEx.SFU.MimeType do
  # Constants
  @mime_type_prefix_audio "audio/"
  @mime_type_prefix_video "video/"

  def mime_type_prefix_audio, do: @mime_type_prefix_audio
  def mime_type_prefix_video, do: @mime_type_prefix_video

  # Codec type definition
  @type codec ::
          :unknown
          | :h264
          | :h265
          | :opus
          | :red
          | :vp8
          | :vp9
          | :av1
          | :g722
          | :pcmu
          | :pcma
          | :rtx
          | :flexfec
          | :ulpfec

  # MimeType definition
  @type mime_type ::
          :unknown
          | :h264
          | :h265
          | :opus
          | :red
          | :vp8
          | :vp9
          | :av1
          | :g722
          | :pcmu
          | :pcma
          | :rtx
          | :flexfec
          | :ulpfec

  @doc """
  Converts a codec atom to its string representation.
  """
  @spec codec_to_string(codec()) :: String.t()
  def codec_to_string(codec) do
    case codec do
      :unknown -> "MimeTypeCodecUnknown"
      :h264 -> "H264"
      :h265 -> "H265"
      :opus -> "opus"
      :red -> "red"
      :vp8 -> "VP8"
      :vp9 -> "VP9"
      :av1 -> "AV1"
      :g722 -> "G722"
      :pcmu -> "PCMU"
      :pcma -> "PCMA"
      :rtx -> "rtx"
      :flexfec -> "flexfec"
      :ulpfec -> "ulpfec"
      _ -> "MimeTypeCodecUnknown"
    end
  end

  @doc """
  Converts a codec to its MIME type.
  """
  @spec codec_to_mime_type(codec()) :: mime_type()
  def codec_to_mime_type(codec) do
    case codec do
      :unknown -> :unknown
      :h264 -> :h264
      :h265 -> :h265
      :opus -> :opus
      :red -> :red
      :vp8 -> :vp8
      :vp9 -> :vp9
      :av1 -> :av1
      :g722 -> :g722
      :pcmu -> :pcmu
      :pcma -> :pcma
      :rtx -> :rtx
      :flexfec -> :flexfec
      :ulpfec -> :ulpfec
      _ -> :unknown
    end
  end

  @doc """
  Normalizes a codec string to a codec atom (case-insensitive).
  """
  @spec normalize_codec(String.t()) :: codec()
  def normalize_codec(codec) do
    case String.downcase(codec) do
      "h264" -> :h264
      "h265" -> :h265
      "opus" -> :opus
      "red" -> :red
      "vp8" -> :vp8
      "vp9" -> :vp9
      "av1" -> :av1
      "g722" -> :g722
      "pcmu" -> :pcmu
      "pcma" -> :pcma
      "rtx" -> :rtx
      "flexfec" -> :flexfec
      "ulpfec" -> :ulpfec
      _ -> :unknown
    end
  end

  @doc """
  Extracts the codec from a MIME type string.
  Returns the codec atom or :unknown if invalid.
  """
  @spec get_codec(String.t()) :: codec()
  def get_codec(mime) do
    case String.split(mime, "/", parts: 2) do
      [_prefix, codec_str] -> normalize_codec(codec_str)
      _ -> :unknown
    end
  end

  @doc """
  Checks if a codec string is Opus (case-insensitive).
  """
  @spec codec_string_opus?(String.t()) :: boolean()
  def codec_string_opus?(codec), do: normalize_codec(codec) == :opus

  @doc """
  Checks if a codec string is RED (case-insensitive).
  """
  @spec codec_string_red?(String.t()) :: boolean()
  def codec_string_red?(codec), do: normalize_codec(codec) == :red

  @doc """
  Checks if a codec string is PCMA (case-insensitive).
  """
  @spec codec_string_pcma?(String.t()) :: boolean()
  def codec_string_pcma?(codec), do: normalize_codec(codec) == :pcma

  @doc """
  Checks if a codec string is PCMU (case-insensitive).
  """
  @spec codec_string_pcmu?(String.t()) :: boolean()
  def codec_string_pcmu?(codec), do: normalize_codec(codec) == :pcmu

  @doc """
  Checks if a codec string is H264 (case-insensitive).
  """
  @spec codec_string_h264?(String.t()) :: boolean()
  def codec_string_h264?(codec), do: normalize_codec(codec) == :h264

  @doc """
  Converts a MIME type atom to its string representation.
  """
  @spec mime_type_to_string(mime_type()) :: String.t()
  def mime_type_to_string(mime_type) do
    case mime_type do
      :h264 -> LiveKitSdkEx.WebRTC.MimeType.h264()
      :h265 -> LiveKitSdkEx.WebRTC.MimeType.h265()
      :opus -> LiveKitSdkEx.WebRTC.MimeType.opus()
      :red -> "audio/red"
      :vp8 -> LiveKitSdkEx.WebRTC.MimeType.vp8()
      :vp9 -> LiveKitSdkEx.WebRTC.MimeType.vp9()
      :av1 -> LiveKitSdkEx.WebRTC.MimeType.av1()
      :g722 -> LiveKitSdkEx.WebRTC.MimeType.g722()
      :pcmu -> LiveKitSdkEx.WebRTC.MimeType.pcmu()
      :pcma -> LiveKitSdkEx.WebRTC.MimeType.pcma()
      :rtx -> LiveKitSdkEx.WebRTC.MimeType.rtx()
      :flexfec -> LiveKitSdkEx.WebRTC.MimeType.flex_fec()
      :ulpfec -> LiveKitSdkEx.WebRTC.MimeType.ulp_fec()
      _ -> "MimeTypeUnknown"
    end
  end

  @doc """
  Normalizes a MIME type string to a MIME type atom (case-insensitive).
  """
  @spec normalize_mime_type(String.t()) :: mime_type()
  def normalize_mime_type(mime) do
    mime_lower = String.downcase(mime)

    cond do
      mime_lower == String.downcase(LiveKitSdkEx.WebRTC.MimeType.h264()) -> :h264
      mime_lower == String.downcase(LiveKitSdkEx.WebRTC.MimeType.h265()) -> :h265
      mime_lower == String.downcase(LiveKitSdkEx.WebRTC.MimeType.opus()) -> :opus
      mime_lower == String.downcase("audio/red") -> :red
      mime_lower == String.downcase(LiveKitSdkEx.WebRTC.MimeType.vp8()) -> :vp8
      mime_lower == String.downcase(LiveKitSdkEx.WebRTC.MimeType.vp9()) -> :vp9
      mime_lower == String.downcase(LiveKitSdkEx.WebRTC.MimeType.av1()) -> :av1
      mime_lower == String.downcase(LiveKitSdkEx.WebRTC.MimeType.g722()) -> :g722
      mime_lower == String.downcase(LiveKitSdkEx.WebRTC.MimeType.pcmu()) -> :pcmu
      mime_lower == String.downcase(LiveKitSdkEx.WebRTC.MimeType.pcma()) -> :pcma
      mime_lower == String.downcase(LiveKitSdkEx.WebRTC.MimeType.rtx()) -> :rtx
      mime_lower == String.downcase(LiveKitSdkEx.WebRTC.MimeType.flex_fec()) -> :flexfec
      mime_lower == String.downcase(LiveKitSdkEx.WebRTC.MimeType.ulp_fec()) -> :ulpfec
      true -> :unknown
    end
  end

  @doc """
  Checks if two MIME type strings are equal (case-insensitive).
  """
  @spec mime_type_string_equal?(String.t(), String.t()) :: boolean()
  def mime_type_string_equal?(mime1, mime2) do
    normalize_mime_type(mime1) == normalize_mime_type(mime2)
  end

  @doc """
  Checks if a MIME type string represents audio.
  """
  @spec mime_type_string_audio?(String.t()) :: boolean()
  def mime_type_string_audio?(mime) do
    String.starts_with?(mime, @mime_type_prefix_audio)
  end

  @doc """
  Checks if a MIME type atom represents audio.
  """
  @spec mime_type_audio?(mime_type()) :: boolean()
  def mime_type_audio?(mime_type) do
    String.starts_with?(mime_type_to_string(mime_type), @mime_type_prefix_audio)
  end

  @doc """
  Checks if a MIME type string represents video.
  """
  @spec mime_type_string_video?(String.t()) :: boolean()
  def mime_type_string_video?(mime) do
    String.starts_with?(mime, @mime_type_prefix_video)
  end

  @doc """
  Checks if a MIME type atom represents video.
  """
  @spec mime_type_video?(mime_type()) :: boolean()
  def mime_type_video?(mime_type) do
    String.starts_with?(mime_type_to_string(mime_type), @mime_type_prefix_video)
  end

  @doc """
  Checks if a MIME type supports SVC (Scalable Video Coding).
  """
  @spec mime_type_svc_capable?(mime_type()) :: boolean()
  def mime_type_svc_capable?(mime_type) do
    mime_type in [:av1, :vp9]
  end

  @doc """
  Checks if a MIME type string supports SVC (case-insensitive).
  """
  @spec mime_type_string_svc_capable?(String.t()) :: boolean()
  def mime_type_string_svc_capable?(mime) do
    mime_type_svc_capable?(normalize_mime_type(mime))
  end

  @doc """
  Checks if a MIME type string is RED (case-insensitive).
  """
  @spec mime_type_string_red?(String.t()) :: boolean()
  def mime_type_string_red?(mime), do: normalize_mime_type(mime) == :red

  @doc """
  Checks if a MIME type string is Opus (case-insensitive).
  """
  @spec mime_type_string_opus?(String.t()) :: boolean()
  def mime_type_string_opus?(mime), do: normalize_mime_type(mime) == :opus

  @doc """
  Checks if a MIME type string is PCMA (case-insensitive).
  """
  @spec mime_type_string_pcma?(String.t()) :: boolean()
  def mime_type_string_pcma?(mime), do: normalize_mime_type(mime) == :pcma

  @doc """
  Checks if a MIME type string is PCMU (case-insensitive).
  """
  @spec mime_type_string_pcmu?(String.t()) :: boolean()
  def mime_type_string_pcmu?(mime), do: normalize_mime_type(mime) == :pcmu

  @doc """
  Checks if a MIME type string is RTX (case-insensitive).
  """
  @spec mime_type_string_rtx?(String.t()) :: boolean()
  def mime_type_string_rtx?(mime), do: normalize_mime_type(mime) == :rtx

  @doc """
  Checks if a MIME type string is VP8 (case-insensitive).
  """
  @spec mime_type_string_vp8?(String.t()) :: boolean()
  def mime_type_string_vp8?(mime), do: normalize_mime_type(mime) == :vp8

  @doc """
  Checks if a MIME type string is VP9 (case-insensitive).
  """
  @spec mime_type_string_vp9?(String.t()) :: boolean()
  def mime_type_string_vp9?(mime), do: normalize_mime_type(mime) == :vp9

  @doc """
  Checks if a MIME type string is H264 (case-insensitive).
  """
  @spec mime_type_string_h264?(String.t()) :: boolean()
  def mime_type_string_h264?(mime), do: normalize_mime_type(mime) == :h264
end
