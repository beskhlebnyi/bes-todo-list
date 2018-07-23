class SendRemindMailJob < ApplicationJob
  queue_as :default

  def perform
    Document.all.each do |document|
      if document.deadline_soon? && !document.reminded
        RemindLetterMailer.remind_email(document.id).deliver_now
        document.reminded = true
        document.save
      end
    end
  end
end