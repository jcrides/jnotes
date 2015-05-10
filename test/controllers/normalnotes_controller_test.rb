require 'test_helper'

class NormalnotesControllerTest < ActionController::TestCase
  test 'should not get index' do
    assert_raises AbstractController::ActionNotFound do
      get :index
    end
  end

  test 'should get show' do
    notebook = create(:notebook)
    normalnote = create(:normalnote, :notebook_id => notebook.id)

    get :show, :id => normalnote.id
    assert_response :success
  end
end
