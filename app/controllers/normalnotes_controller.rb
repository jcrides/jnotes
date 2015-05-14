class NormalnotesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_current_note, :only => [:show]
  before_action :require_authorized_for_notes, :only => [:show]

  def show
  end

  def new
    @normalnote = Normalnote.new(:notebook_id => params[:notebook_id])
  end

  def edit
    @normalnote = Normalnote.where(:id => params[:id]).first
  end

  def create
    @notebook = Notebook.where(:id => params[:notebook_id]).first
    @normalnote = @notebook.normalnotes.create(normalnote_params)
    if @normalnote.valid?
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

  helper_method :current_note
  def current_note
    @normalnote ||= Normalnote.where(:id => params[:id]).first
  end

  def require_authorized_for_notes
    if current_note.notebook.user != current_user
      render :text => 'This is not your note', :status => :unauthorized
    end
  end

  def require_current_note
    unless current_note
      render :text => 'There is no such note', :status => :not_found
    end
  end
end
