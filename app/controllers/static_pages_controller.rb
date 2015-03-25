class StaticPagesController < ApplicationController
  def home
    @albums = Album.order("year DESC")
    @comments = Comment.latest
  end

  def about
  end

  def contact
  end
end
