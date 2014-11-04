require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:test_user)
    # This code is not idiomatically correct.
    @score = @user.scores.build(time: '1.23', level: 1)
  end

  test "score should be valid" do
    assert_equal @score.time, "1.23"
  end

#   test "user id should be present" do
#     @score.user_id = nil
#     assert_not @score.valid?
#   end
 end
