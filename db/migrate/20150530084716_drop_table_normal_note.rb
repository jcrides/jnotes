class DropTableNormalNote < ActiveRecord::Migration
  def change
    drop_table :normalnotes
  end
end
