# Preview all emails at http://localhost:3000/rails/mailers/photo
class PhotoPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/photo/share
  def share
    Photo.share
  end

end
