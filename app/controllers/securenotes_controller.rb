class SecurenotesController < ApplicationController
  def show
    @securenote = Securenote.where(:id => params[:id]).first
  end

  def new
    @securenote = Securenote.new(:notebook_id => params[:notebook_id])
  end

  def edit
    @securenote = Securenote.where(:id => params[:id]).first
  end

  def create
    @notebook = Notebook.where(:id => params[:notebook_id]).first
    @securenote = @notebook.securenotes.create(securenote_params)
    if @securenote.valid?
      redirect_to @securenote
    else
      render 'new'
    end
  end

  def update
    @securenote = Securenote.where(:id => params[:id]).first
    if @securenote.update(securenote_params)
      redirect_to @securenote
    else
      render 'edit'
    end
  end

  private
  def securenote_params
    params.require(:securenote).permit(:title, :note_text, :attachments, :notebook_id)
  end
end
