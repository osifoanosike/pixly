class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :likes

  def user_already_liked?(user_email)
    result = Like.where("email = ? and photo_id = ?", user_email, id)
    logger.error("existing_likes:  #{result.any?}")
    if result.any?
      return true 
    else 
      return false
    end
  end

  def like(current_user_email)
    like = Like.create(email: current_user_email, photo_id: id)
    increment!('like_count', 1)
  end
end
