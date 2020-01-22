class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = "Please log in"
    redirect_to login_path
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def admin_or_elder_user
    redirect_to root_path unless current_user.admin? || current_user.elder?
  end
end
