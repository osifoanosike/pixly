class UsersController < ApplicationController
  def index
  end

  def refer
    invite_link = "http://localhost:3000/welcome?welcome_id=" + current_user.set_referral_key
    invite_info = { email: params[:invitee_email], link: invite_link }
    Invite.send_invite(invite_info).deliver_now

    redirect_to root_url, notcie: "Your invitation has been sent to #{params["invitee_email"]}"
  end

  def welcome

  end
end
