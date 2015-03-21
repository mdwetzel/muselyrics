class Song < ActiveRecord::Base
	belongs_to :album
	extend FriendlyId
	friendly_id :title, use: :slugged

	has_many :comments, dependent: :destroy

	validates :title, presence: true, length: { maximum: 150 }
	validates :track, presence: true, numericality: { only_integer: true }
	validates :lyrics, presence: true, length: { maximum: 5000 }
end
