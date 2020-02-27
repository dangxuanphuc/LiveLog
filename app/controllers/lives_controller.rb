class LivesController < ApplicationController
  before_action :set_live, only: %i[edit update destroy]
  before_action :logged_in_user, except: %i[index show]
  before_action :admin_or_elder_user, except: %i[index show]

  def index
    @lives = Live.order_by_date
  end

  def show
    @live = Live.includes(:songs).find(params[:id])
  end

  def new
    @live = Live.new
    @live.date = Date.today
  end

  def edit; end

  def create
    @live = Live.new live_params

    if @live.save
      flash[:success] = "#{@live.title} created successfully!"
      redirect_to @live
    else
      render :new
    end
  end

  def update
    if @live.update_attributes live_params
      flash[:success] = "#{@live.title} を更新しました"
      redirect_to @live
    else
      render :edit
    end
  end

  def destroy
    @live.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      flash.now[:danger] = e.message
      render :show
    else
      flash[:success] = "Delete live successfully!"
      redirect_to lives_path
  end

  private

  def set_live
    @live = Live.find_by id: params[:id]

    return if @live
    flash[:danger] = "Cannot find this live"
    redirect_to root_path
  end

  def live_params
    params.require(:live).permit :name, :date, :place, :album_url
  end
end
