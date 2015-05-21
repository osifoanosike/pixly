class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
# after_action :save_referral, only: [:create]

  #POST /resource
  def create
    super do
      if resource.persisted? && params[:sender_id]
        Referral.create!(referer_id: params[:sender_id], referee_id: resource.id)
      end
    end
  end
end
