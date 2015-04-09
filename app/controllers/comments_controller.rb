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

    if @comment.save
      redirect_to album_song_path(@comment.song.album, @comment.song),
        notice: 'Comment was successfully created.'
    else
      set_comment_prerequisites
      render 'songs/show'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to album_song_path(@comment.song.album, @comment.song),
        notice: 'Comment was successfully updated.' 
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to album_song_path(@comment.song.album, @comment.song),
      notice: 'Comment was successfully destroyed.' 
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_comment_prerequisites
      @album = @comment.song.album
      @song = @comment.song
      @songs = @song.other_tracks_on_album
      @comments = @song.comments_by_score
    end

    def comment_params
      params.require(:comment).permit(:body, :song_id)
    end
end
