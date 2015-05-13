class FoldersController < ApplicationController
  before_action :authenticate_user!

  def index
    @folders = Folder.where(:user_id => current_user.id)
  end

  def show
    @folder = Folder.where(:id => params[:id]).first
    if @folder.blank?
      render :text => 'Folder not found', :status => :not_found
    else
      if @folder.user != current_user
        render :text => 'This is not your folder', :status => :unauthorized
      end
      @links = Link.where(:folder_id => params[:id])
    end
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
    @folder = Folder.where(:id => params[:id]).first
    if @folder.blank?
      render :text => 'Folder not found', :status => :not_found
    else
      if @folder.user != current_user
        render :text => 'This is not your folder', :status => :unauthorized
      end
    end
  end

  def update
    @folder = Folder.where(:id => params[:id]).first
    if @folder.user == current_user
      if @folder.update_attributes(folder_params)
        redirect_to @folder
      else
        render 'edit'
      end
    else
      render :text => 'This is not your folder', :status => :unauthorized
    end
  end

  def destroy
    @folder = Folder.where(:id => params[:id]).first
    if @folder.user == current_user
      @folder.destroy
      redirect_to folders_path
    else
      render :text => 'This is not your folder', :status => :unauthorized
    end
  end

  private
  def folder_params
    params.require(:folder).permit(:name)
  end
end
