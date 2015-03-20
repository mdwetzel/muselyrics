class Album < ActiveRecord::Base
	has_many :songs, dependent: :destroy
	accepts_nested_attributes_for :songs
	
	extend FriendlyId
	friendly_id :title, use: :slugged

	mount_uploader :image, ImageUploader
end
