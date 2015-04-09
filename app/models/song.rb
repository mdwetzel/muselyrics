class Song < ActiveRecord::Base

	extend FriendlyId
	friendly_id :title, use: :slugged

	belongs_to :album
	has_many :comments, dependent: :destroy

	validates :title, 
						presence: true,
						length: { maximum: 150 }

	validates :track,
						presence: true,
						numericality: {
							only_integer: true,
							greater_than: 0 }

	validates :lyrics,
						presence: true,
						length: { maximum: 5000 }

	validates :album,
						presence: true

	def self.search(query)
  	query.empty? ? Song.all : 
  		Song.where("LOWER(title) LIKE ?", "%#{query.downcase}%") 
	end

	def self.madness
		Song.find_by(title: "Madness")
	end

	def other_tracks_on_album
		album.songs.order('track').where.not(id: self)
	end

	def comments_by_score
		comments.order(cached_votes_up: :desc)
	end
end
