class LivesController < ApplicationController
  before_action :set_live, only: %i(show edit update destroy)
  before_action :logged_in_user, except: %i(index show)
  before_action :admin_or_elder_user, except: %i(index show)

  def index
    @lives = Live.all
  end

  def show
    @songs = @live.songs
  end

  def new
    @live = Live.new
  end

  def edit; end

  def create
    @live = Live.new live_params

    respond_to do |format|
      if @live.save
        format.html do
          flash[:success] = "#{@live.title} を追加しました"
          redirect_to @live
        end
      else
        format.html { render :new }
        format.json { render json: @live.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @live.update_attributes live_params
        format.html do
          flash[:success] = "#{@live.title} を更新しました"
          redirect_to @live
        end
      else
        format.html { render :edit }
        format.json { render json: @live.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    begin
      @live.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      flash.now[:danger] = e.message
      render :show
    else
      flash[:success] = "Delete live successfully!"
      redirect_to lives_path
    end
  end

  private

  def set_live
    @live = Live.find_by id: params[:id]

    return if @live
    flash[:danger] = "Cannot find this live"
    redirect_to root_path
  end

  def live_params
    params.require(:live).permit :name, :date, :place
  end
end
