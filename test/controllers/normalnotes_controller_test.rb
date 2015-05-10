require 'test_helper'

class NormalnotesControllerTest < ActionController::TestCase
  setup do
    @notebook = create(:notebook)
    @normalnote = create(:normalnote, :notebook_id => @notebook.id)
  end

  test 'should not get index' do
    assert_raises AbstractController::ActionNotFound do
      get :index
    end
  end

  test 'should get show' do
    get :show, :id => @normalnote.id
    assert_response :success
  end

  test 'should get new' do
    get :new, :notebook_id => @notebook.id

    assert_response :success
    assert_template 'new'
  end

  test 'should get edit' do
    get :edit, :id => @normalnote.id

    assert_response :success
    assert_template 'edit'
  end

  test 'should update note title' do
    put :update, :id => @normalnote.id, :normalnote => { :title => 'Update Test'}

    assert normalnote = Normalnote.find_by_title('Update Test')
    assert_redirected_to normalnote_path(normalnote.id)
  end

  test 'should not update note title' do
    put :update, :id => @normalnote.id, :normalnote => { :title => ''}

    refute normalnote = Normalnote.find_by_title('')
    assert_template 'edit'
  end

  test 'should create normalnote' do
    post :create, :notebook_id => @notebook.id,
                  :normalnote => {
                    :title => 'Create Test',
                    :note_text => 'Create me for testing.'
                  }
    assert normalnote = Normalnote.find_by_title('Create Test')
    assert_redirected_to normalnote_path(normalnote.id)
  end

  test 'should not create normalnote' do
    post :create, :notebook_id => @notebook.id,
         :normalnote => {
             :title => '',
             :note_text => 'Create me for testing.'
         }
    refute normalnote = Normalnote.find_by_title('')
    assert_template 'new'
  end
end
