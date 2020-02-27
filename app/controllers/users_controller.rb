class UsersController < ApplicationController
  before_action :logged_in_user, except: %i[index show]
  before_action :check_public, only: :show
  before_action :find_user, only: %i[edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_or_elder_user, only: :destroy

  def index
    if params[:active] != "true"
      @users = User.natural_order
    else
      today = Date.today
      range = (today - 1.year..today)
      @users = User.natural_order.includes(songs: :live).where("lives.date" => range)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new create_user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @playings = Playing.where(song_id: @user.songs.pluck("songs.id"))
  end

  def edit; end

  def update
    if @user.update_attributes update_user_params
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

  def create_user_params
    params.require(:user).permit :first_name, :last_name,
      :furigana, :email, :joined, :password
  end

  def update_user_params
    params.require(:user).permit :first_name, :last_name,
      :furigana, :nickname, :email, :joined, :password,
      :password_confirmation, :url, :intro, :public
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = "Cannot find this user!"
    redirect_to root_path
  end

  def correct_user
    redirect_to root_path unless @user.current_user? current_user
  end

  def check_public
    @user = User.includes(songs: :live).find(params[:id])
    redirect_to root_path unless logged_in? || @user.public?
  end
end
