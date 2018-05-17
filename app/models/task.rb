class Task < ApplicationRecord
  belongs_to :list
  validates  :content, presence: true, uniqueness: { scope: :list_id }

  def deadline_soon?
    self.deadline ? self.deadline >= DateTime.now - 2.hours && self.important : false
  end
end

##NOTE
## get the timezone offset in hours:
## Task.last.deadline.strftime('%z')[0..2].to_i 