class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  acts_as_votable

  validates :body, presence: true, length: { maximum: 5000 }

  def score
  	get_upvotes.count - get_downvotes.count
  end
end
