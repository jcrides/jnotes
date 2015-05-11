class Folder < ActiveRecord::Base
  validates :name, :presence => true, :length => { :minimum => 1, :maximum => 80 }

  belongs_to :user
end
