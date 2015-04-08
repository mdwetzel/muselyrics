class UsersController < ApplicationController
  def profile
  	if params[:id]
	  	@user = User.where("lower(username) LIKE ?", 
	  		params[:id].downcase).first
	  else
	  	@user = current_user
	  end

    @latest = @user.comments
  end
end
