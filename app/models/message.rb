class Message < ActiveRecord::Base

  validates :body,
            presence: true

	validates :name,
            presence: true

	validates :email,
            presence: true
end
