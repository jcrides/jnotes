require 'test_helper'

class SecurenotesControllerTest < ActionController::TestCase
  setup do
    @notebook = create(:notebook)
    @securenote = create(:securenote, :notebook_id => @notebook.id)
  end

  test 'should not get index' do
    assert_raises AbstractController::ActionNotFound do
      get :index
    end
  end

  test 'should get show' do
    get :show, :id => @securenote.id
    assert_response :success
  end

  test 'should get new' do
    get :new, :notebook_id => @notebook.id

    assert_response :success
    assert_template 'new'
  end

  test 'should get edit' do
    get :edit, :id => @securenote.id

    assert_response :success
    assert_template 'edit'
  end

  test 'should update note title' do
    put :update, :id => @securenote.id, :securenote => { :title => 'Update Test'}

    assert securenote = Securenote.find_by_title('Update Test')
    assert_redirected_to securenote_path(securenote.id)
  end

  test 'should not update note title' do
    put :update, :id => @securenote.id, :securenote => { :title => ''}

    refute securenote = Normalnote.find_by_title('')
    assert_template 'edit'
  end

  test 'should create securenote' do
    post :create, :notebook_id => @notebook.id,
         :securenote => {
             :title => 'Create Test',
             :note_text => 'Create me for testing.'
         }
    assert securenote = Securenote.find_by_title('Create Test')
    assert_redirected_to securenote_path(securenote.id)
  end

  test 'should not create securenote' do
    post :create, :notebook_id => @notebook.id,
         :securenote => {
             :title => '',
             :note_text => 'Create me for testing.'
         }
    refute securenote = Securenote.find_by_title('')
    assert_template 'new'
  end
end
