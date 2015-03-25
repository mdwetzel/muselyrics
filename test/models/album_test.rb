require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
	setup do
    @album = albums(:absolution)
	end

  test "the fixture should be valid" do
    assert @album.save
  end

  test "it should have a title" do
    @album.title = ""
    assert !@album.save
  end

  test "it should have a title 150 characters or less" do
    @album.title = "a" * 151
    assert !@album.save
    @album.title = "a" * 150
    assert @album.save
  end

  test "it should have a description 5000 characters or less" do
    @album.description = "a" * 5001
    assert !@album.save
    @album.description = "a" * 5000
    assert @album.save
  end

  test "it should have a year" do
    @album.year = nil
    assert !@album.save
    @album.year = ""
    assert !@album.save
    @album.year = Time.now.year
    assert @album.save
  end

  test "it should have a valid year in integer format" do
    @album.year = 123.4
    assert !@album.save
  end

  test "it should have a valid year on or after 1990 and before or on the current year" do
    @album.year = 1989
    assert !@album.save
    @album.year = Time.now.year + 1
    assert !@album.save
    @album.year = 1990
    assert @album.save
    @album.year = Time.now.year
    assert @album.save
  end
end
