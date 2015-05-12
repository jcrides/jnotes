class Normalnote < ActiveRecord::Base
  validates :title, :presence => true, :length => { :minimum => 1 }

  belongs_to :notebook
  belongs_to :user
end
