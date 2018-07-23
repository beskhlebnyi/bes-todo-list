class List < ApplicationRecord
  has_many   :files, dependent: :destroy
  has_many   :shared_lists, dependent: :destroy
  belongs_to :user
  validates  :title, presence: true, uniqueness: { scope: :user_id }
end
