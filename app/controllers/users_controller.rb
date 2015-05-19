class UsersController < ApplicationController
  def index
  end

  def refer
    invite_info = setup_referal
    Invite.send_invite(invite_info).deliver_now
    redirect_to root_url, notice: "Your invitation has been sent to #{params["invitee_email"]}"
  end

  def setup_referal
    invite_link = "http://localhost:3000/welcome?welcome=" + params[:invitee_email] + "&id=" + current_user.set_referral_key
    invite_info = { email: params[:invitee_email], link: invite_link }
  end

  def welcome
    @referee = params[:welcome]
    @referer = User.decrypt_referral_key(params[:id])
    render "devise/registrations/new", locals:{ resource: User.new }, layout: "welcome"
  end
end
