class Like < ActiveRecord::Base
  belongs_to :photo
  validates_uniqueness_of :photo, :scope => [:email], message: 'Already Liked'
end
