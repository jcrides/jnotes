class NormalnotesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_current_note, :only => [:show, :edit, :update]
  before_action :require_authorized_for_notes, :only => [:show]

  def show
  end

  def new
    @normalnote = Normalnote.new(:notebook_id => params[:notebook_id])
  end

  def edit
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
    if current_note.update(normalnote_params)
      redirect_to current_note
    else
      render 'edit'
    end
  end

  def destroy
    current_note.destroy
    redirect_to notebook_path(current_note.notebook_id)
  end

  private
  def normalnote_params
    params.require(:normalnote).permit(:title, :note_text, :attachments, :notebook_id, :tag_list)
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
