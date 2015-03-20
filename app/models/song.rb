class Song < ActiveRecord::Base
	belongs_to :album
	extend FriendlyId
	friendly_id :title, use: :slugged
end
