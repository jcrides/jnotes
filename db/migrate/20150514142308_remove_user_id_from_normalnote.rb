class RemoveUserIdFromNormalnote < ActiveRecord::Migration
  def change
    remove_column :normalnotes, :user_id
  end
end
