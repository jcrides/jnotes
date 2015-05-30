require 'test_helper'

class SecurenotesControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    sign_in @user
    @notebook = create(:notebook, :user_id => @user.id)
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

  test 'show should fail if not right user' do
    user = create(:user)
    notebook = create(:notebook, :user_id => user.id)
    securenote = create(:securenote, :notebook_id => notebook.id)

    get :show, :id => securenote.id
    assert_response :unauthorized
  end

  test 'show should get 404' do
    get :show, :id => '-1'

    assert_response :not_found
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

    refute securenote = Securenote.find_by_title('')
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

  test 'should delete securenote' do
    delete :destroy, :id => @securenote.id
    assert_raises ActiveRecord::RecordNotFound do
      refute Securenote.find(@securenote.id)
    end
    assert_redirected_to notebook_path(@securenote.notebook_id)
  end
end
