require 'test_helper'

class SongTest < ActiveSupport::TestCase

  setup do
    @song = songs(:hysteria)
  end

  test "the fixture should be valid" do
    assert @song.save
  end 

  test "it should have a title" do
    @song.title = ""
    assert !@song.save
  end

  test "it should have a title 150 characters or less do" do
    @song.title = "a" * 151
    assert !@song.save
    @song.title = "a" * 150
    assert @song.save
  end

  test "it should have lyrics" do
    @song.lyrics = ""
    assert !@song.save
    @song.lyrics = "blah " * 100
    assert @song.save
  end

  test "it should have lyrics 5000 characters or less" do
    @song.lyrics = "a" * 5001
    assert !@song.save
    @song.lyrics = "a"* 5000
    assert @song.save
  end

  test "it should belong to an album" do
    @song.album = nil
    assert !@song.save
  end

  test "it should have a track" do
    @song.track = nil
    assert !@song.save
  end

  test "it should have a track that's only a positive integer" do
    [-1, 0].each do |track|
      @song.track = track
      assert !@song.save
    end
  end

  test "search should return all songs when given an empty query" do
    songs = Song.search("")

    assert_equal songs.count, Song.count
  end

  test "search should return the correct songs for the query" do
    q = songs(:hysteria).title[1, -1]
    songs = Song.search(q)

    songs.each do |song|
      assert_match /.#{q}./i, song.title
    end
  end
end
