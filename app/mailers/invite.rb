class Invite < ApplicationMailer
  def send_invite(invite_options)
    @invite = invite_options
    mail to: invite_options[:email], subject: "Hi, would like you to share stuff with you on pixly"
  end
end