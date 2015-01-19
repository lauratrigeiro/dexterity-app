require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
  def setup
	@base_title = "Dexterity App"
  @user = users(:tom)
end

  test "should get home for user that is not logged in" do
    get :home
    assert_response :success
    assert_select "title", @base_title
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", new_user_registration_path, count: 2
    assert_select "a[href=?]", new_user_session_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", course_1_path, count: 0
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "layout links for user that is logged in" do
    sign_in @user
    get :home
    assert_response :success
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", new_user_registration_path, count: 0
    assert_select "a[href=?]", new_user_session_path, count: 0
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", course_1_path
    assert_select "a[href=?]", course_2_path
    assert_select "a[href=?]", course_3_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", scores_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_registration_path
    assert_select "a[href=?]", destroy_user_session_path
  end

end
