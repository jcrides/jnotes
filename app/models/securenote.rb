class Securenote < ActiveRecord::Base
  belongs_to :notebook
  attr_encrypted :note_text, :key => 'super secret key'
end
