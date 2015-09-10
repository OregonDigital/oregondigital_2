class Video < GenericAsset
  has_derivatives :webm, :mp4, :video_thumbnail

  # has_derivatives creates methods per the name of the derivative, but we need
  # the video thumbnail to act as any other thumbnail would
  alias_method :has_thumbnail, :has_video_thumbnail
  alias_method :has_thumbnail=, :has_video_thumbnail=
  alias_method :thumbnail_path, :video_thumbnail_path
  alias_method :thumbnail_path=, :video_thumbnail_path=
end
