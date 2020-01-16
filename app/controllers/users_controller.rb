class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :find_user, except: %i(new create index)
  before_action :admin_user, only: %i(destroy)

  def index
    @users = User.all.page(params[:page]).per Settings.size_page_max_length
    @years = User.select(:joined).distinct.order(joined: :desc).map { |u| u.joined }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Profile update successfully!"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "Delete user successfully!"
    else
      flash[:danger] = "Something went wrong!"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :first_name, :last_name,
      :furigana, :nickname, :email, :joined, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = "Cannot find this user!"
    redirect_to root_path
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
