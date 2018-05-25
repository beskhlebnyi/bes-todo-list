class RemindLetterMailer < ApplicationMailer

  def remind_email(task_id)
    @task = Task.find(task_id)
    mail(to: 'beskhlebnyi@gmail.com', subject: 'Amazon SES mail')
    ##TODO
    ##uncomment next line after increase sending limit
    ##mail(to: @task.list.user.email, subject: 'You have some task to do!')
  end

end
