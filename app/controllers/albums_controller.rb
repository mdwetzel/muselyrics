class AlbumsController < ApplicationController

  before_action :set_album, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  def show
    @songs = @album.songs_by_track
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to @album, notice: 'Album was successfully created.'
    else
      render :new
    end
  end

  def update
    if @album.update(album_params)
      redirect_to @album, notice: 'Album was successfully updated.'
    else
      render :edit
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @album.destroy
    redirect_to albums_url, notice: 'Album was successfully destroyed.'
  end

  private

    def set_album
      @album = Album.friendly.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:title, :description, :year, :image)
    end
end
