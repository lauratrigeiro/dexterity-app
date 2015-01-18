require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:tom)
    # This code is not idiomatically correct.
    @score = @user.scores.build(time: 123, course: 1)
  end

  test "score should be valid" do
    assert_equal @score.time, 123
  end

#   test "user id should be present" do
#     @score.user_id = nil
#     assert_not @score.valid?
#   end
 end
