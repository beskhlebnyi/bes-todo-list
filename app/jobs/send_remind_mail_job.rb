class SendRemindMailJob < ApplicationJob
  queue_as :default

  def perform
    Task.all.each do |task|
      if task.deadline_soon?
        RemindLetterMailer.remind_email(task.id).deliver_now
      end
    end
  end
end