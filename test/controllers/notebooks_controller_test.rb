require 'test_helper'

class NotebooksControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    sign_in @user
    @notebook = create(:notebook, :user_id => @user.id)
  end

  test 'should get index' do
    get :index

    assert_response :success
  end

  test 'should get show' do
    get :show, :id => @notebook.id

    assert_response :success
  end

  test 'should get new' do
    get :new

    assert_response :success
  end

  test 'should get edit' do
    get :edit, :id => @notebook.id

    assert_response :success
  end

  test 'should update name' do
    put :update, :id => @notebook.id, :notebook => { :name => 'Something' }

    assert notebook = Notebook.find_by_name('Something')
    assert_redirected_to notebook_path(notebook.id)
  end

  test 'should not update name' do
    put :update, :id => @notebook.id, :notebook => { :name => '' }

    refute Notebook.find_by_name('')
    assert_template 'edit'
  end

  test 'should create notebook' do
    post :create, :notebook => { :name => 'Testing'}

    assert notebook = Notebook.find_by_name('Testing')
    assert_redirected_to notebook_path(notebook.id)
  end

  test 'should not create notebook' do
    post :create, :notebook => { :name => ''}

    refute Notebook.find_by_name('')
    assert_template 'new'
  end

  test 'should delete notebook' do
    notebook = create(:notebook, :user_id => @user.id)

    delete :destroy, :id => notebook.id
    assert_raises ActiveRecord::RecordNotFound do
      refute Notebook.find(notebook.id)
    end
    assert_redirected_to notebooks_path
  end
end
