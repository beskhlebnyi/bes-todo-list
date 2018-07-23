class RemindLetterMailer < ApplicationMailer

  def remind_email(file_id)
    @file = File.find(file_id)
    mail(to: 'beskhlebnyi@gmail.com', subject: 'Amazon SES mail')
    ##TODO
    ##uncomment next line after increase sending limit
    ##mail(to: @file.list.user.email, subject: 'You have some file to do!')
  end

end
