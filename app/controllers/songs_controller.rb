class SongsController < ApplicationController

  before_action :set_album, only: [:new, :edit, :show, :update, :create]
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  def index
    @songs = Song.all
  end

  def show
    @songs = @album.songs.order('track')
    @songs = @songs.where.not(id: @song)
    @comments = @song.comments.order('created_at')
    @comment = Comment.new
  end

  def new
    @song = Song.new
  end

  def edit
  end

  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to [@song.album, @song], notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to [@song.album, @song], notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_song
      @song = Song.friendly.find(params[:id])
    end

    def song_params
      params.require(:song).permit(:title, :lyrics, :description, :album_id, :track)
    end

    def set_album
      @album = Album.friendly.find(params[:album_id])
    end
end
