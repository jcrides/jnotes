class Link < ActiveRecord::Base
  validates :title, :presence => true, :length => { :minimum => 1 }
  validates :url, :presence => true, :length => { :minimum => 10 }

  belongs_to :folder
end
