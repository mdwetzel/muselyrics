class UsersController < ApplicationController
  def profile
  	@user = User.where("lower(username) LIKE ?", 
  		params[:id].downcase).first
  end
end
