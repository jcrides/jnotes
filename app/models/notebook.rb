class Notebook < ActiveRecord::Base
  include TaggingHelpers

  validates :name, :presence => true, :length => { :minimum => 1, :maximum => 80 }

  belongs_to :user
  has_many :normalnotes
  has_many :securenotes

  acts_as_taggable
end
