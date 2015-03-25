class Album < ActiveRecord::Base
	
	extend FriendlyId
	friendly_id :title, use: :slugged

	has_many :songs, dependent: :destroy
	accepts_nested_attributes_for :songs

	mount_uploader :image, ImageUploader

	validates :title, presence: true, length: { maximum: 150 }
	validates :description, length: { maximum: 5000 }
	validates :year, presence: true, numericality: { only_integer: true,
		greater_than_or_equal_to: 1990, less_than_or_equal_to: Time.now.year }
end
