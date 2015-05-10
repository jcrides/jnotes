class DeleteDescriptionFromSecurenote < ActiveRecord::Migration
  def change
    change_table :securenotes do |t|
      t.remove :description
    end
  end
end
