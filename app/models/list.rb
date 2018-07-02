class List < ApplicationRecord
  has_many   :tasks, dependent: :destroy
  has_many   :shared_lists
  belongs_to :user
  validates  :title, presence: true, uniqueness: { scope: :user_id }
end
