class NotebooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @notebooks = Notebook.all
  end

  def show
    @notebook = Notebook.where(:id => params[:id]).first
    @normalnotes = Normalnote.where(:notebook_id => params[:id])
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
    @notebook = Notebook.where(:id => params[:id]).first
  end

  def update
    @notebook = Notebook.where(:id => params[:id]).first
    if @notebook.update_attributes(notebook_params)
      redirect_to @notebook
    else
      render 'edit'
    end
  end

  def destroy
    @notebook = Notebook.where(:id => params[:id]).first
    @notebook.destroy

    redirect_to notebooks_path
  end

  private
  def notebook_params
    params.require(:notebook).permit(:name)
  end
end
