class ApplicationMailer < ActionMailer::Base
  ##TODO
  ##change 'from' email address after increase sending limit
  default from: 'rubydrynash@gmail.com'
  layout 'mailer'
end
