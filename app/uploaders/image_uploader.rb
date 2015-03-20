# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  process resize_to_fit: [500, 500]

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
