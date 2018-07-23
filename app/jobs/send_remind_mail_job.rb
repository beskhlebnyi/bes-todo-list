class SendRemindMailJob < ApplicationJob
  queue_as :default

  def perform
    Document.all.each do |file|
      if file.deadline_soon? && !file.reminded
        RemindLetterMailer.remind_email(file.id).deliver_now
        file.reminded = true
        file.save
      end
    end
  end
end