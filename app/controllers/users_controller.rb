class UsersController < ApplicationController
  def profile
    @user = params[:id].nil? ? current_user :
      User.find_by_username(params[:id])
    end
end
