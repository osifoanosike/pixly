# Preview all emails at http://localhost:3000/rails/mailers/photo_mailer
class PhotoMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/photo_mailer/share
  def share
    PhotoMailer.share
  end

end
