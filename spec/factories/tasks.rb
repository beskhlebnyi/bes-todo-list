FactoryBot.define do
  factory :task do
    important true
    status true
    sequence(:content) { |n| "Some #{n} Content"}

    trait :with_list do
      list { create :list }
    end
  end
end
