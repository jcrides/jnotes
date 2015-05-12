class LinksController < ApplicationController
  def show
    @link = Link.where(:id => params[:id]).first
  end

  def new
    @link = Link.new(:folder_id => params[:folder_id])
  end

  def edit
    @link = Link.where(:id => params[:id]).first
  end

  def create
    @folder = Folder.where(:id => params[:folder_id]).first
    @link = @folder.links.create(link_params.merge({ :user_id => current_user.id }))
    if @link.valid?
      redirect_to @link
    else
      render 'new'
    end
  end

  def update
    @link = Link.where(:id => params[:id]).first
    if @link.update(link_params)
      redirect_to @link
    else
      render 'edit'
    end
  end

  private
  def link_params
    params.require(:link).permit(:title, :url, :description, :folder_id)
  end
end
