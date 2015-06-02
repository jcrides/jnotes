class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_current_folder, :only => [:show, :edit, :update, :destroy]
  before_action :require_authorized_for_folders, :only => [:show, :edit, :update, :destroy]

  def index
    @folders = Folder.where(:user_id => current_user.id)
  end

  def show
    @links = Link.where(:folder_id => params[:id])
  end

  def new
    @folder = Folder.new
  end

  def create
    @folder = current_user.folders.create(folder_params)
    if @folder.valid?
      redirect_to @folder
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if current_folder.update_attributes(folder_params)
      redirect_to current_folder
    else
      render 'edit'
    end
  end

  def destroy
    current_folder.destroy
    redirect_to folders_path
  end

  def add_tag
    current_folder.add_tag(params[:tag])
    # TODO: should add some validation that the tag saved
    redirect_to current_folder
  end

  def del_tag
    current_folder.remove_tag(params[:tag])
    # TODO: should add some validation that the tag was delted
    redirect_to current_folder
  end

  private
  def folder_params
    params.require(:folder).permit(:name, :tag_list)
  end

  helper_method :current_folder
  def current_folder
    @folder ||= Folder.where(:id => params[:id]).first
  end

  def require_authorized_for_folders
    if current_folder.user != current_user
      render :text => 'This is not your folder', :status => :unauthorized
    end
  end

  def require_current_folder
    unless current_folder
      render :text => 'There is no such folder', :status => :not_found
    end
  end
end
