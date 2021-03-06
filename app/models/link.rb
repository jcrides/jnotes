class Link < ActiveRecord::Base
  include TaggingHelpers

  validates :title, :presence => true, :length => { :minimum => 1 }
  validates :url, :presence => true, :length => { :minimum => 10 }

  belongs_to :folder

  acts_as_taggable
end
