require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "not logged in index" do
    get :index
    assert_response :success
  end

  test "logged in index" do
    user = create(:user)
    sign_in user

    get :index, :user_id => user
    assert_response :success
  end
end
