class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :song

  acts_as_votable

  validates :body,
            presence: true,
            length: { maximum: 5000 }
  
  validates :user,
            presence: true
  
  validates :song,
            presence: true

  def score
  	get_upvotes.count - get_downvotes.count
  end

  def self.latest
  	self.order('created_at DESC').limit(25)
  end
end
