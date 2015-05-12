class FoldersController < ApplicationController
  before_action :authenticate_user!

  def index
    @folders = Folder.all
  end

  def show
    @folder = Folder.where(:id => params[:id]).first
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
    @folder = Folder.where(:id => params[:id]).first
  end

  def update
    @folder = Folder.where(:id => params[:id]).first
    if @folder.update_attributes(folder_params)
      redirect_to @folder
    else
      render 'edit'
    end
  end

  def destroy
    @folder = Folder.where(:id => params[:id]).first
    @folder.destroy

    redirect_to folders_path
  end

  private
  def folder_params
    params.require(:folder).permit(:name)
  end

end
