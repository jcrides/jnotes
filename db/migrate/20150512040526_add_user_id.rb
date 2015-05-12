class AddUserId < ActiveRecord::Migration
  def change
    change_table :links do |t|
      t.integer :user_id
    end

    change_table :normalnotes do |t|
      t.integer :user_id
    end

    change_table :securenotes do |t|
      t.integer :user_id
    end
  end
end
