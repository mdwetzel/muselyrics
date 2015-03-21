class Song < ActiveRecord::Base
	belongs_to :album
	extend FriendlyId
	friendly_id :title, use: :slugged

	has_many :comments, dependent: :destroy
end
