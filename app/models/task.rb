class Task < ApplicationRecord
  belongs_to :list
  validates  :content, presence: true, uniqueness: { scope: :list_id }

  def deadline_soon?
    if self.deadline && self.important
      task_deadline = utc_client_deadline
      task_deadline <= Time.current.utc + 2.hours
    else
      false
    end
  end

  def client_deadline(client_timezone)
    self.deadline + utc_client_deadline.in_time_zone(client_timezone).utc_offset
  end

  def deadline_argument(arg)
    self.client_deadline(self.timezone).to_time.strftime(arg)
  end

  private

  def utc_client_deadline
    self.deadline - self.deadline.in_time_zone(self.timezone).utc_offset
  end
end

##NOTE
## get the timezone offset in hours:
## Task.last.deadline.strftime('%z')[0..2].to_i 