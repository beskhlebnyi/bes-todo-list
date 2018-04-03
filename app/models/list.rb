class List < ApplicationRecord
  has_many  :tasks, dependent: :destroy
  validates :title, presence: true, uniqueness: true
end
