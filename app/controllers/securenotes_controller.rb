class SecurenotesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_current_snote, :only => [:show, :edit, :update]
  before_action :require_authorized_for_snote, :only => [:show]

  def show
  end

  def new
    @securenote = Securenote.new(:notebook_id => params[:notebook_id])
  end

  def edit
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
    if current_snote.update(securenote_params)
      redirect_to current_snote
    else
      render 'edit'
    end
  end

  def destroy
    current_snote.destroy
    redirect_to notebook_path(current_snote.notebook_id)
  end

  private
  def securenote_params
    params.require(:securenote).permit(:title, :note_text, :attachments, :notebook_id, :tag_list)
  end

  helper_method :current_snote
  def current_snote
    @securenote ||= Securenote.where(:id => params[:id]).first
  end

  def require_authorized_for_snote
    if current_snote.notebook.user != current_user
      render :text => 'This is not your note', :status => :unauthorized
    end
  end

  def require_current_snote
    unless current_snote
      render :text => 'There is no such note', :status => :not_found
    end
  end
end
