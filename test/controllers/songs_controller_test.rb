require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  setup do
    @song = songs(:hysteria)
    set_test_users
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:songs)
  end

  test "should NOT get new as a user" do
    sign_in @user
    get :new, album_id: @song.album
    assert_redirected_to root_path
  end

  test "should NOT get new as a guest" do
    get :new, album_id: @song.album
    assert_redirected_to login_path 
  end

  test "should get new as an admin" do
    sign_in @admin
    get :new, album_id: @song.album
    assert_response :success
  end

  test "should create song as an admin" do
    sign_in @admin
    assert_difference('Song.count') do
      post :create, album_id: @song.album, song: { description: @song.description,
        lyrics: @song.lyrics, title: @song.title, track: @song.track }
    end

    assert_redirected_to song_path(assigns(:song))
  end

  test "should show song" do
    get :show, id: @song, album_id: @song.album
    assert_response :success
  end

  test "should NOT get edit as a guest" do
    get :edit, id: @song, album_id: @song.album
    assert_redirected_to login_path
  end

  test "should get edit as a user" do
    sign_in @user
    get :edit, id: @song, album_id: @song.album
    assert_response :success
  end

  test "should get edit as an admin" do
    sign_in @admin
    get :edit, id: @song, album_id: @song.album
    assert_response :success
  end

  test "should NOT update song as a guest" do
    patch :update, id: @song, album_id: @song.album, song: { description: @song.description,
      lyrics: @song.lyrics, title: @song.title, track: @song.track }
    
    assert_redirected_to login_path
  end

  test "should update song as a user" do
    sign_in @user
    patch :update, id: @song, album_id: @song.album, song: { description: @song.description,
      lyrics: @song.lyrics, title: @song.title, track: @song.track }
    
    assert_redirected_to album_song_path(@song.album, assigns(:song))
  end

  test "should update song as an admin" do
    sign_in @admin
    patch :update, id: @song, album_id: @song.album, song: { description: @song.description,
      lyrics: @song.lyrics, title: @song.title, track: @song.track }
    
    assert_redirected_to album_song_path(@song.album, assigns(:song))
  end

  test "should NOT destroy song as a guest" do
    assert_no_difference('Song.count', -1) do
      delete :destroy, id: @song
    end

    assert_redirected_to login_path
  end

  test "should NOT destroy song as a user" do
    sign_in @user
    assert_no_difference('Song.count', -1) do
      delete :destroy, id: @song
    end

    assert_redirected_to root_path
  end

  test "should destroy song as an admin" do
    sign_in @admin
    assert_difference('Song.count', -1) do
      delete :destroy, id: @song
    end

    assert_redirected_to songs_path
  end
end
