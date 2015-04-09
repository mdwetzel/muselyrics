class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  process resize_to_fit: [500, 500]

  version :thumb_tiny do
    process :resize_to_fill => [50, 50]
  end

  version :thumb_1 do
    process :resize_to_fill => [100, 100]
  end

  version :thumb_2 do
    process :resize_to_fill => [200, 200]
  end

  version :thumb_3 do
    process :resize_to_fill => [300, 300]
  end

  version :thumb_4 do
    process :resize_to_fill => [400, 400]
  end
end