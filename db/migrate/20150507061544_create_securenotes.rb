class CreateSecurenotes < ActiveRecord::Migration
  def change
    create_table :securenotes do |t|
      t.string :title
      t.text :encrypted_note_text
      t.integer :notebook_id
      t.string :description
      t.string :attachments

      t.timestamps null: false
    end
  end
end
