class CreateNormalnotes < ActiveRecord::Migration
  def change
    create_table :normalnotes do |t|
      t.string :title
      t.text :note_text
      t.integer :notebook_id
      t.string :attachments

      t.timestamps null: false
    end
  end
end
