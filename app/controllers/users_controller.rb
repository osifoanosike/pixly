class UsersController < ApplicationController
  def index
  end

  def refer
    url = request.base_url
    invite_info = setup_referal(url)
    Invite.send_invite(invite_info).deliver_now
    redirect_to url, notice: "Your invitation has been sent to #{params["invitee_email"]}"
  end

  def setup_referal(host_url)
    invite_link = host_url +"/welcome?welcome=#{params[:invitee_email]}&id=#{current_user.set_referral_key}"
    invite_info = { email: params[:invitee_email], link: invite_link }
  end

  def welcome
    @referee = params[:welcome]
    @referer = User.decrypt_referral_key(params[:id])
    render "devise/registrations/new", locals:{ resource: User.new }, layout: nil
  end
end
