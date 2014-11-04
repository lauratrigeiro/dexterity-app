require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

    def setup
 #   @user = User.new(username: "ExampleUser", email: "user@example.com")
 	@user = users(:test_user)
  end

  # test "should be valid" do
  #   assert @user.valid?
  # end
end
