class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      elsif user.id # if logged in
      	can [:create, :update], Song
      end

  	  can :read, :all
  end
end
