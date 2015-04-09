class CommentsController < ApplicationController
  
  before_action :set_comment, only: [:edit, :update, :destroy, :upvote, :downvote]

  load_and_authorize_resource

  def upvote  
    remove = false
    if current_user.voted_up_on?(@comment)
      remove = true
      @comment.unliked_by current_user
    else
      @comment.liked_by current_user
    end
    
    respond_to do |format|
      format.json { render json: { score: @comment.score, type: "upvote", 
        remove: remove  } }
    end
  end

  def downvote
    remove = false
    if current_user.voted_down_on?(@comment)
      remove = true
      @comment.undisliked_by current_user
    else
      @comment.disliked_by current_user
    end

    respond_to do |format|
      format.json { render json: { score: @comment.score, type: "downvote",
        remove: remove } }
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
