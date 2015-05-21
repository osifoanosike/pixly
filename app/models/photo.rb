class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  belongs_to :category
end
