class PhotoMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.photo_mailer.share.subject
  #
  def share(share_info)
    @share_info = share_info

    mail to: share_info['email'], subject: "Hi saw this pic on pixly, i think you might like it"
  end
end
