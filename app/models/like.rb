class Like < ActiveRecord::Base
  belongs_to :photo
  validates_uniqueness_of :photo, :scope => [:email], message: 'Already Liked'
  after_save :increase_photo_like_count

  def increase_photo_like_count
    self.photo.increment!(:like_count, 1)
  end
end
