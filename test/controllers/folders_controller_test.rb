require 'test_helper'

class FoldersControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    sign_in @user
    @folder = create(:folder, :user_id => @user.id)
  end

  test "should get index" do
    get :index

    assert_response :success
  end

  test "should get show" do
    get :show, :id => @folder.id

    assert_response :success
  end

  test 'show should fail if not right user' do
    user = create(:user)
    folder = create(:folder, :user_id => user.id)

    get :show, :id => folder.id
    assert_response :unauthorized
  end

  test 'show should get 404' do
    get :show, :id => '-1'

    assert_response :not_found
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @folder.id

    assert_response :success
  end

  test 'should update name' do
    put :update, :id => @folder.id, :folder => { :name => 'Something' }

    assert folder = Folder.find_by_name('Something')
    assert_redirected_to folder_path(folder.id)
  end

  test 'should not update name' do
    put :update, :id => @folder.id, :folder => { :name => '' }

    refute Folder.find_by_name('')
    assert_template 'edit'
  end

  test 'should create folder' do
    post :create, :folder => { :name => 'Testing'}

    assert folder = Folder.find_by_name('Testing')
    assert_redirected_to folder_path(folder.id)
  end

  test 'should not create folder' do
    post :create, :folder => { :name => ''}

    refute Folder.find_by_name('')
    assert_template 'new'
  end

  test 'should delete folder' do
    folder = create(:folder, :user_id => @user.id)

    delete :destroy, :id => folder.id
    assert_raises ActiveRecord::RecordNotFound do
      refute Folder.find(folder.id)
    end
    assert_redirected_to folders_path
  end

  test 'should add tag' do
    post :add_tag, :id => @folder.id, :tag => 'jello'

    assert_equal ['jello'], @folder.tag_list, 'Should add jello tag'
  end

  test 'should remove tag' do
    post :add_tag, :id => @folder.id, :tag => 'jello'
    delete :del_tag, :id => @folder.id, :tag => 'jello'

    assert_equal [], @folder.tag_list, 'Should delete jello tag'
  end
end
