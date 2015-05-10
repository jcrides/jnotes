class Notebook < ActiveRecord::Base
  belongs_to :user
  has_many :normalnotes
  has_many :securenotes
end
