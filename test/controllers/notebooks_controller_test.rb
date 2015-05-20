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

  test 'show should fail if not right user' do
    user = create(:user)
    notebook = create(:notebook, :user_id => user.id)

    get :show, :id => notebook.id
    assert_response :unauthorized
  end

  test 'show should get 404' do
    get :show, :id => '-1'

    assert_response :not_found
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

  test 'should add tag' do
    post :add_tag, :id => @notebook.id, :tag => 'jello'

    assert_equal ['jello'], @notebook.tag_list, 'Should add jello tag'
  end

  # TODO: why isn't this working, works when called from view
  test 'should remove tag' do
    post :add_tag, :id => @notebook.id, :tag => 'jello'
    delete :del_tag, :id => @notebook.id, :jello => '1'

    assert_equal [], @notebook.tag_list, 'Should delete jello tag'
  end
end
