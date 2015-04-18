class StaticPagesController < ApplicationController
  def home
    @albums = Album.order("year DESC")
    @comments = Comment.includes(:user, song: [:album]).latest
  end

  def about
  end

  def contact
  end
end
