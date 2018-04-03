FactoryBot.define do
  factory :task do
    important true
    status true
    sequence(:content) { |n| "Some #{n} Content"}
    association :list
  end
end
