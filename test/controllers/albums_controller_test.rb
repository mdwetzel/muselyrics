require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  setup do
    @album = albums(:absolution)
    set_test_users
  end

  test "should NOT get new as a guest" do
    get :new
    assert_redirected_to login_path
  end

  test "should NOT get new as a user" do
    sign_in @user
    get :new
    assert_redirected_to root_path
  end

  test "should NOT get new as an admin" do
    sign_in @admin
    get :new
    assert_response :success
  end

  test "should NOT create album as a guest" do
    assert_no_difference('Album.count') do
      post :create, album: { description: @album.description, title: @album.title, year: @album.year }
    end

    assert_redirected_to login_path
  end

  test "should NOT create album as a user" do
    sign_in @user
    assert_no_difference('Album.count') do
      post :create, album: { description: @album.description, title: @album.title, year: @album.year }
    end

    assert_redirected_to root_path
  end

  test "should create album as an admin" do
    sign_in @admin
    assert_difference('Album.count') do
      post :create, album: { description: @album.description, title: @album.title, year: @album.year }
    end

    assert_redirected_to album_path(assigns(:album))
  end

  test "should show album" do
    get :show, id: @album
    assert_response :success
  end

  test "should NOT get edit as a guest" do
    get :edit, id: @album
    assert_redirected_to login_path
  end

  test "should NOT get edit as a user" do
    sign_in @user
    get :edit, id: @album
    assert_redirected_to root_path
  end

  test "should get edit as an admin" do
    sign_in @admin
    get :edit, id: @album
    assert_response :success
  end

  test "should NOT update album as a guest" do
    patch :update, id: @album, album: { description: @album.description, title: @album.title, year: @album.year }
    assert_redirected_to login_path
  end

  test "should NOT update album as a user" do
    sign_in @user
    patch :update, id: @album, album: { description: @album.description, title: @album.title, year: @album.year }
    assert_redirected_to root_path
  end

  test "should update album as an admin" do
    sign_in @admin
    patch :update, id: @album, album: { description: @album.description, title: @album.title, year: @album.year }
    assert_redirected_to album_path(assigns(:album))
  end

  test "should NOT destroy album as a guest" do
    assert_no_difference('Album.count', -1) do
      delete :destroy, id: @album
    end

    assert_redirected_to login_path
  end

  test "should NOT destroy album as a user" do
    sign_in @user
    assert_no_difference('Album.count', -1) do
      delete :destroy, id: @album
    end

    assert_redirected_to root_path
  end

  test "should destroy album as an admin" do
    sign_in @admin
    assert_difference('Album.count', -1) do
      delete :destroy, id: @album
    end

    assert_redirected_to albums_path
  end
end
