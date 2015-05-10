require 'test_helper'

class SecurenotesControllerTest < ActionController::TestCase
  test 'should not get index' do
    assert_raises AbstractController::ActionNotFound do
      get :index
    end
  end

  test 'should get show' do
    notebook = create(:notebook)
    securenote = create(:securenote, :notebook_id => notebook.id)

    get :show, :id => securenote.id
    assert_response :success
  end
end
