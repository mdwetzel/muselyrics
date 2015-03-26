require 'test_helper'

class CommentTest < ActiveSupport::TestCase
	setup do
		@comment = comments(:user_comment)
	end

	test "the fixture should be valid" do
		assert @comment.save
	end

	test "it should have a body" do
		@comment.body = ""
		assert !@comment.save
		@comment.body = "Muse is a great band!"
		assert @comment.save
	end

	test "it should have a body 5000 characters or less" do
		@comment.body = "a" * 5001
		assert !@comment.save
		@comment.body = "a" * 5000
		assert @comment.save
	end

	test "it should belong to a user" do
		@comment.user = nil
		assert !@comment.save
	end

	test "it should belong to a song" do
		@comment.song = nil
		assert !@comment.save
	end
end
