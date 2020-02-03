class StaticPagesController < ApplicationController
  def home
    @songs = Song.all.page(params[:page]).per Settings.size_page_max_length
  end

  def about
  end
end
