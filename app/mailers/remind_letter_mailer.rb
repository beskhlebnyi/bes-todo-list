class RemindLetterMailer < ApplicationMailer

  def remind_email(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'You have some task to do!')
  end

end
