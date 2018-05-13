class RemindLetterMailer < ApplicationMailer
  
  def remind_email(email)
    mail(to: email, subject: 'You have some task to do!')
  end

end
