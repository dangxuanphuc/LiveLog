class SongsController < ApplicationController
  before_action :logged_in_user, except: :index
  before_action :find_song, only: %i(show edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_or_elder_user, only: %i(new create destroy)
  before_action :store_location, only: :edit
  before_action :set_users, only: %i(new create edit update)

  def index
    @songs = Song.search(params[:q], params[:page])
  end

  def new
    live = params[:live_id] ? Live.find(params[:live_id]) : Live.first
    @song = live.songs.build
    @song.playings.build
  end

  def create
    @song = Song.new song_params
    if @song.save
      flash[:success] = "曲を追加しました"
      redirect_to @song.live
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @song.update_attributes song_params
      flash[:success] = "Update song successfully!"
      redirect_back_or @song
    else
      render :edit
    end
  end

  def destroy
    live = @song.live
    @song.destroy
    flash[:success] = "Delete song successfully!"
    redirect_back_or live
  end

  private

  def find_song
    @song = Song.find_by id: params[:id]

    return if @song
    flash[:danger] = "Cannot find this song"
    redirect_to live_path
  end

  def song_params
    params.require(:song).permit :live_id, :time, :order,
      :name, :artist, :youtube_id,
      playings_attributes: %i(id user_id inst _destroy)
  end

  def store_location
    session[:forwarding_url] = request.referer || root_path
  end

  def set_users
    @users = User.all
  end

  def correct_user
    redirect_to root_path unless current_user.played?(@song) || current_user.admin_or_elder?
  end
end
