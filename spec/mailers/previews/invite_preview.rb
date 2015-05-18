# Preview all emails at http://localhost:3000/rails/mailers/invite
class InvitePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invite/send
  def send
    Invite.send
  end

end
