FactoryBot.define do
  factory :task do
    important true
    status true
    deadline Date.tomorrow
    sequence(:content) { |n| "Some #{n} Content"}

    trait :with_list do
      list { create :list }
    end
  end
end
