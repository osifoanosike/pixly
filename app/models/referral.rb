class Referral < ActiveRecord::Base
  def self.create(referer, referee)
    self.create(referee_id: referee.id, referer_id: referer.id)
  end
end
