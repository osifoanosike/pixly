class User < ActiveRecord::Base
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :photos
  has_many :referrals, foreign_key: "referer_id"

  attr_accessor :sender_id
  after_create :set_referral, if: :sender_id

  def set_referral_key
    verifier = ActiveSupport::MessageVerifier.new("appinvites")
    return verifier.generate(id)
  end

  def self.decrypt_referral_key(referral_key)
    verifier = ActiveSupport::MessageVerifier.new("appinvites")
    verifier.verify(referral_key)
  end

  def set_referral
    Referral.create!(referer_id: self.sender_id, referee_id: self.id)
  end
end
