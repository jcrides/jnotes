class NotebooksController < ApplicationController
  before_action :authenticate_user!
  before_action :require_current_notebook, :only => [:show, :edit, :update, :destroy, :add_tag, :del_tag]
  before_action :require_authorized_for_notebooks, :only => [:show, :edit, :update, :destroy, :add_tag, :del_tag]

  def index
    @notebooks = Notebook.where(:user_id => current_user.id)
  end

  def show
    @securenotes = Securenote.where(:notebook_id => params[:id])
  end

  def new
    @notebook = Notebook.new
  end

  def create
    @notebook = current_user.notebooks.create(notebook_params)
    if @notebook.valid?
      redirect_to @notebook
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if current_notebook.update_attributes(notebook_params)
      redirect_to current_notebook
    else
      render 'edit'
    end
  end

  def destroy
    current_notebook.destroy
    redirect_to notebooks_path
  end

  def add_tag
    current_notebook.add_tag(params[:tag])
    # TODO: should add some validation that the tag saved
    redirect_to current_notebook
  end

  def del_tag
    current_notebook.remove_tag(params[:tag])
    # TODO: should add some validation that the tag was delted
    redirect_to current_notebook
  end

  private
  def notebook_params
    params.require(:notebook).permit(:name, :tag_list)
  end

  helper_method :current_notebook
  def current_notebook
    @notebook ||= Notebook.where(:id => params[:id]).first
  end

  def require_authorized_for_notebooks
    if current_notebook.user != current_user
      render :text => 'This is not your notebook', :status => :unauthorized
    end
  end

  def require_current_notebook
    unless current_notebook
      render :text => 'There is no such notebook', :status => :not_found
    end
  end
end
