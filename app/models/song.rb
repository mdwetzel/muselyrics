class Song < ActiveRecord::Base
	belongs_to :album
	extend FriendlyId
	friendly_id :title, use: :slugged

	has_many :comments, dependent: :destroy

	validates :title, presence: true, length: { maximum: 150 }
	validates :track, presence: true, numericality: { only_integer: true, greater_than: 0 }
	validates :lyrics, presence: true, length: { maximum: 5000 }
	validates :album, presence: true

	def self.search(q)
	  	if q
	      Song.where("LOWER(title) LIKE ?", "%#{q.downcase}%")
	    else
	      Song.all
	    end
	end

	def self.madness
		Song.find_by(title: "Madness")
	end
end
