class NormalnotesController < ApplicationController
  def show
    @normalnote = Normalnote.where(:id => params[:id]).first
  end

  def new
    @normalnote = Normalnote.new
  end

  def edit
    @normalnote = Normalnote.where(:id => params[:id]).first
  end

  def create
    @normalnote = Normalnote.new(normalnote_params)
    if @normalnote.save
      redirect_to @normalnote
    else
      render 'new'
    end
  end

  def update
    @normalnote = Normalnote.where(:id => params[:id]).first
    if @normalnote.update(normalnote_params)
      redirect_to @normalnote
    else
      render 'edit'
    end
  end

  private
  def normalnote_params
    params.require(:normalnote).permit(:title, :note_text, :attachments, :notebook_id)
  end
end
