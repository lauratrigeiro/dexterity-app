require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
  	@user = users(:tom)
  	@other_user = users(:julia)
  	@no_scores_user = users(:afif)
  	@score = @user.scores.first
  end

  test "should redirect index when not logged in" do
  	get :index
  	assert_redirected_to new_user_session_url
  end

  test "should redirect show when not logged in" do
  	get :show, id: @user
  	assert_redirected_to new_user_session_url
  end

  test "should redirect show when logged in as wrong user" do
  	sign_in @other_user
  	get :show, id: @user
  	assert_redirected_to root_url
  end

  test "should get index when logged in" do
	sign_in @user
	get :index
	assert_response :success
	assert_select "table", true
	assert_select "a[href=?]", user_path(@user), count: 2
	assert_select "a[href=?]", user_path(@other_user)
	assert_match @other_user.email, response.body
	assert_match @other_user.created_at.strftime("%B %e, %Y"), response.body
  end

  test "should get show when logged in, but don't display table if no scores" do
	sign_in @no_scores_user
	get :show, id: @no_scores_user
	assert_response :success
	assert_select "h1", "My Times"
	assert_select "table", false
  end

  test "should get show when logged in and display table if scores" do
	sign_in @user
	get :show, id: @user
	assert_response :success
	assert_select "h1", "My Times"
	assert_select "table", true
	assert_match '%.3f' % (@score.time / 1000.0).to_s, response.body
  end

end
