class Securenote < ActiveRecord::Base
  include TaggingHelpers

  validates :title, :presence => true, :length => { :minimum => 1 }

  belongs_to :notebook
  attr_encrypted :note_text, :key => 'super secret key'

  acts_as_taggable
end
