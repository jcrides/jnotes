class Securenote < ActiveRecord::Base
  validates :title, :presence => true, :length => { :minimum => 1 }

  belongs_to :notebook
  belongs_to :user
  attr_encrypted :note_text, :key => 'super secret key'
end
