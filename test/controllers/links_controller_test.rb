require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  setup do
    @folder = create(:folder)
    @link = create(:link, :folder_id => @folder.id)
  end

  test 'should not get index' do
    assert_raises AbstractController::ActionNotFound do
      get :index
    end
  end

  test 'should get show' do
    get :show, :id => @link.id
    assert_response :success
  end

  test 'should get new' do
    get :new, :folder_id => @folder.id

    assert_response :success
    assert_template 'new'
  end

  test 'should get edit' do
    get :edit, :id => @link.id

    assert_response :success
    assert_template 'edit'
  end

  test 'should update link title' do
    put :update, :id => @link.id, :link => { :title => 'Update Test'}

    assert link = Link.find_by_title('Update Test')
    assert_redirected_to link_path(link.id)
  end

  test 'should not update link title' do
    put :update, :id => @link.id, :link => { :title => ''}

    refute link = Link.find_by_title('')
    assert_template 'edit'
  end

  test 'should update link url' do
    put :update, :id => @link.id, :link => { :url => 'http://www.yahoo.com'}

    assert link = Link.find_by_url('http://www.yahoo.com')
    assert_redirected_to link_path(link.id)
  end

  test 'should not update link url' do
    put :update, :id => @link.id, :link => { :url => ''}

    refute link = Link.find_by_url('')
    assert_template 'edit'
  end

  test 'should create link' do
    post :create, :folder_id => @folder.id,
         :link => {
             :title => 'Create Test',
             :url => 'http://www.yahoo.com',
             :description => 'Create me for testing.'
         }
    assert link = Link.find_by_title('Create Test')
    assert_redirected_to link_path(link.id)
  end

  test 'should not create link' do
    post :create, :folder_id => @folder.id,
         :link => {
             :title => '',
             :url => 'http://www.yahoo.com',
             :description => 'Create me for testing.'
         }
    refute link = Link.find_by_title('')
    assert_template 'new'
  end
end
