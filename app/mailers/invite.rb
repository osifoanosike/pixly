class Invite < ApplicationMailer
  
  def send_invite(invite_options)
    @invite = invite_options
    mail to: invite_options[:email], subject: "Hi, would like to share stuff with you on pixly"
  end

  # def share_photo(share_info)
  #   @share_info = share_info

  #   mail to: share_info[:email], subject: "Hi saw this pic on pixly, i think you might like it"
  # end
end