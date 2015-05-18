class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true

  # after_save :set_referral_key

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :photos

  def set_referral_key
    verifier = ActiveSupport::MessageVerifier.new(ENV['ref_generation_key'])
    return verifier.generate(email)
  end
end
