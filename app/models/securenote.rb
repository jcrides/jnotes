class Securenote < ActiveRecord::Base
  validates :title, :presence => true, :length => { :minimum => 1 }

  belongs_to :notebook
  attr_encrypted :note_text, :key => 'super secret key'
end
