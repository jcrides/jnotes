class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.string :description
      t.integer :folder_id

      t.timestamps null: false
    end
  end
end
