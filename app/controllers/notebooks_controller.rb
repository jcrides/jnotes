class NotebooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @notebooks = Notebook.all.where(:user_id => current_user.id)
  end

  def show
    @notebook = Notebook.where(:id => params[:id]).first
    if @notebook.blank?
      render :text => 'Notebook not found', :status => :not_found
    else
      if @notebook.user != current_user
        render :text => 'This is not your notebook', :status => :unauthorized
      end
      @normalnotes = Normalnote.where(:notebook_id => params[:id])
      @securenotes = Securenote.where(:notebook_id => params[:id])
    end
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
    @notebook = Notebook.where(:id => params[:id]).first
    if @notebook.blank?
      render :text => 'Notebook not found', :status => :not_found
    else
      if @notebook.user != current_user
        render :text => 'This is not your notebook', :status => :unauthorized
      end
    end
  end

  def update
    @notebook = Notebook.where(:id => params[:id]).first
    if @notebook.user == current_user
      if @notebook.update_attributes(notebook_params)
        redirect_to @notebook
      else
        render 'edit'
      end
    else
      render :text => 'This is not your notebook', :status => :unauthorized
    end
  end

  def destroy
    @notebook = Notebook.where(:id => params[:id]).first
    if @notebook.user == current_user
      @notebook.destroy
      redirect_to notebooks_path
    else
      render :text => 'This is not your notebook', :status => :unauthorized
    end
  end

  private
  def notebook_params
    params.require(:notebook).permit(:name)
  end
end
