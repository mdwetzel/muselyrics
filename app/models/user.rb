class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable

  acts_as_voter

  has_many :comments, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 16 }

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def latest_comments
    comments.order('created_at DESC').take(3)
  end

  def self.find_by_username(username)
    User.where("lower(username) LIKE ?", 
        username).first
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) =
        :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end
end