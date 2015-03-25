ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include Devise::TestHelpers

  def set_test_users
	@user = users(:user)
	@user_two = users(:user_two)
    @admin = users(:admin)
  end
end
