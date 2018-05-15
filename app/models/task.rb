class Task < ApplicationRecord
  belongs_to :list
  validates  :content, presence: true, uniqueness: { scope: :list_id }

  def deadline_soon?
    self.deadline ? self.deadline <= DateTime.now.utc - 2.hours && self.important : false
  end
end
