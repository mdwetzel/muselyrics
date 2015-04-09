class SongsController < ApplicationController

  before_action :set_album, only: [:new, :edit, :show, :update, :create]
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  def index
    @songs = Song.search(params[:q])
  end

  def show
    @comment = Comment.new
    @songs = @song.other_tracks_on_album
    @comments = @song.comments_by_score
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to [@song.album, @song], notice: 'Song was successfully created.'
    else
      render :new 
    end
  end

  def update
    if @song.update(song_params)
      redirect_to [@song.album, @song], notice: 'Song was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @song.destroy
    redirect_to [@song.album, @song], notice: 'Song was successfully destroyed.'
  end

  private

    def set_song
      @song = Song.friendly.find(params[:id])
    end

    def song_params
      params.require(:song).permit(:title, :lyrics, :description, :album_id,
        :track)
    end

    def set_album
      @album = Album.friendly.find(params[:album_id])
    end
end
