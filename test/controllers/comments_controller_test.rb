require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:user_comment)
    set_test_users
  end

  test "should NOT get new" do
    assert_raises(AbstractController::ActionNotFound) do
      get :new
    end
  end

  test "should NOT get index" do
    assert_raises(AbstractController::ActionNotFound) do
      get :index
    end
  end

  test "should NOT create comment as a guest" do
    assert_no_difference('Comment.count') do
      post :create, comment: { body: @comment.body, song_id: Song.first, album_id: Album.first }
    end

    assert_redirected_to login_path
  end

  test "should create comment as a user" do
    sign_in @user
    assert_difference('Comment.count') do
      post :create, comment: { body: @comment.body, song_id: Song.first, user_id: @user, album_id: Album.first }
    end

    assert_redirected_to album_song_path(@comment.song.album, @comment.song)
  end

  test "should create comment as an admin" do
    sign_in @admin
    assert_difference('Comment.count') do
      post :create, comment: { body: @comment.body, song_id: Song.first, user_id: User.first, album_id: Album.first }
    end

    assert_redirected_to album_song_path(@comment.song.album, @comment.song)
  end

  test "should NOT get edit as a guest" do
    get :edit, id: @comment
    assert_redirected_to login_path
  end

  test "should get edit as the correct user" do
    sign_in @user
    get :edit, id: @comment
    assert_response :success
  end

  test "should NOT get edit as the incorrect user" do
    sign_in @user_two
    get :edit, id: @comment
    assert_redirected_to root_path
  end

  test "should get edit as an admin" do
    sign_in @admin
    get :edit, id: @comment
    assert_response :success
  end

  test "should NOT destroy comment as a guest" do
    assert_no_difference('Comment.count', -1) do
      delete :destroy, id: @comment.id
    end

    assert_redirected_to login_path
  end

  test "should NOT destroy comment as the incorrect user" do
    sign_in @user_two
    assert_no_difference('Comment.count', -1) do
      delete :destroy, id: @comment.id
    end

    assert_redirected_to root_path
  end

  test "should destroy comment as the correct user" do
    sign_in @user
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment.id
    end

    assert_redirected_to album_song_path(@comment.song.album, @comment.song)
  end

  test "should destroy any comment as an admin" do
    sign_in @admin
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment.id
    end

    assert_difference('Comment.count', -1) do
      delete :destroy, id: comments(:user_two_comment).id
    end

    assert_difference('Comment.count', -1) do
      delete :destroy, id: comments(:admin_comment).id
    end

    assert_redirected_to album_song_path(@comment.song.album, @comment.song)
  end
end
