class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy, :upvote, :downvote]

  load_and_authorize_resource

  def upvote
    @comment.liked_by current_user

    respond_to do |format|
      format.json { render json: { score: @comment.score } }
    end
  end

  def downvote
    @comment.downvote_from current_user

    respond_to do |format|
      format.json { render json: { score: @comment.score } }
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to album_song_path(@comment.song.album, @comment.song),
        notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        set_comment_prerequisites
        format.html { render 'songs/show' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
      format.html { redirect_to album_song_path(@comment.song.album, @comment.song),
        notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to album_song_path(@comment.song.album, @comment.song),
        notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_comment_prerequisites
      @album = @comment.song.album
      @song = @comment.song
      @songs = @album.songs.order('track').where.not(id: @song)
      @comments = @song.comments.order('created_at')
    end

    def comment_params
      params.require(:comment).permit(:body, :song_id)
    end
end
