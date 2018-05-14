class SendRemindMailJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    RemindLetterMailer.remind_email(user_id).deliver_now
  end
end