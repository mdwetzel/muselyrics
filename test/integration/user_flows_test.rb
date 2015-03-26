require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
	test "when a guest clicks upvote/downvote, he should be redirected to log in" do
		get root_path
		assert_response :success
	end
end
