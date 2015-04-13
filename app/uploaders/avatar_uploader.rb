class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/avatars/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/" +
      [version_name, "default_avatar.jpg"].compact.join('_'))
  end

  process resize_to_fit: [150, 150]
end
