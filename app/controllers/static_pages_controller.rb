class StaticPagesController < ApplicationController
  def index
    if current_user
      @folders = Folder.where(:user_id => current_user.id)
      @notebooks = Notebook.where(:user_id => current_user.id)
    end
  end
end
