class RemindLetterMailer < ApplicationMailer

  def remind_email(task_id)
    @task = Task.find(task_id)
    mail(to: @task.list.user.email, subject: 'You have some task to do!')
  end

end
