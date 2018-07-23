class RemindLetterMailer < ApplicationMailer

  def remind_email(document_id)
    @document = Document.find(document_id)
    mail(to: 'beskhlebnyi@gmail.com', subject: 'Amazon SES mail')
    ##TODO
    ##uncomment next line after increase sending limit
    ##mail(to: @document.list.user.email, subject: 'You have some document to do!')
  end

end
