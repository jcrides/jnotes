class Normalnote < ActiveRecord::Base
  validates :title, :presence => true, :length => { :minimum => 1 }

  belongs_to :notebook

  def to_param
    if self.slug.present?
      return self.slug
    else
      return self.id
    end
  end
end
