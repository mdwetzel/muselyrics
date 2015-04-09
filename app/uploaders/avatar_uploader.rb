class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/avatars/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  process resize_to_fit: [75, 75]
end
