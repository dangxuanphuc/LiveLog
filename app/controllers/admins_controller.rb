class AdminsController < ApplicationController
  before_action :admin_user
  before_action :set_user

  def create
    @user.update(admin: true)
    flash[:success] = "Set role admin successfully!"
    redirect_to @user
  end

  def destroy
    @user.update(admin: false)
    flash[:success] = "Remove role admin successfully!"
    redirect_to @user
  end

  private

  def set_user
    @user = User.find_by id: params[:user_id]

    return if @user
    flash[:danger] = "User not found"
    redirect_to root_path
  end
end
