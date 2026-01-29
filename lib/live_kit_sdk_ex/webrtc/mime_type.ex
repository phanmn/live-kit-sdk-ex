defmodule LiveKitSdkEx.WebRTC.MimeType do
  @moduledoc """
  WebRTC MIME type constants.
  Note: Matching should be case insensitive.
  """

  # H264 MIME type
  @mime_type_h264 "video/H264"

  # H265 MIME type
  @mime_type_h265 "video/H265"

  # Opus MIME type
  @mime_type_opus "audio/opus"

  # VP8 MIME type
  @mime_type_vp8 "video/VP8"

  # VP9 MIME type
  @mime_type_vp9 "video/VP9"

  # AV1 MIME type
  @mime_type_av1 "video/AV1"

  # G722 MIME type
  @mime_type_g722 "audio/G722"

  # PCMU MIME type
  @mime_type_pcmu "audio/PCMU"

  # PCMA MIME type
  @mime_type_pcma "audio/PCMA"

  # RTX MIME type
  @mime_type_rtx "video/rtx"

  # FlexFEC MIME type
  @mime_type_flex_fec "video/flexfec"

  # FlexFEC03 MIME type
  @mime_type_flex_fec03 "video/flexfec-03"

  # UlpFEC MIME type
  @mime_type_ulp_fec "video/ulpfec"

  # Public accessor functions
  def h264, do: @mime_type_h264
  def h265, do: @mime_type_h265
  def opus, do: @mime_type_opus
  def vp8, do: @mime_type_vp8
  def vp9, do: @mime_type_vp9
  def av1, do: @mime_type_av1
  def g722, do: @mime_type_g722
  def pcmu, do: @mime_type_pcmu
  def pcma, do: @mime_type_pcma
  def rtx, do: @mime_type_rtx
  def flex_fec, do: @mime_type_flex_fec
  def flex_fec03, do: @mime_type_flex_fec03
  def ulp_fec, do: @mime_type_ulp_fec
end
