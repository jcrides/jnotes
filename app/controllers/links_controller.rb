class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :require_current_link, :only => [:show, :edit, :update]
  before_action :require_authorized_for_links, :only => [:show]

  def show
  end

  def new
    @link = Link.new(:folder_id => params[:folder_id])
  end

  def edit
  end

  def create
    @folder = Folder.where(:id => params[:folder_id]).first
    @link = @folder.links.create(link_params)
    if @link.valid?
      redirect_to @link
    else
      render 'new'
    end
  end

  def update
    if current_link.update(link_params)
      redirect_to current_link
    else
      render 'edit'
    end
  end

  def destroy
    current_link.destroy
    redirect_to folder_path(current_link.folder_id)
  end

  def add_tag
    current_link.add_tag(params[:tag])
    # TODO: should add some validation that the tag saved
    redirect_to current_link
  end

  def del_tag
    current_link.remove_tag(params[:tag])
    # TODO: should add some validation that the tag was delted
    redirect_to current_link
  end

  private
  def link_params
    params.require(:link).permit(:title, :url, :description, :folder_id, :tag_list)
  end

  helper_method :current_link
  def current_link
    @link ||= Link.where(:id => params[:id]).first
  end

  def require_authorized_for_links
    if current_link.folder.user != current_user
      render :text => 'This is not your link', :status => :unauthorized
    end
  end

  def require_current_link
    unless current_link
      render :text => 'There is no such link', :status => :not_found
    end
  end
end
