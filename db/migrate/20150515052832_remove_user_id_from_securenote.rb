class RemoveUserIdFromSecurenote < ActiveRecord::Migration
  def change
    remove_column :securenotes, :user_id
  end
end
