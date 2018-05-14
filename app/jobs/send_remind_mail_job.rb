class SendRemindMailJob < ApplicationJob
  queue_as :default

  def perform
    Task.all.each do |task|
      if task.deadline_soon? && !task.reminded
        RemindLetterMailer.remind_email(task.id).deliver_now
        task.reminded = true
        task.save
      end
    end
  end
end