FactoryBot.define do
  factory :file do
    important true
    status true
    deadline Date.tomorrow
    timezone 'Kamchatka'
    sequence(:content) { |n| "Some #{n} Content"}

    trait :with_list do
      list { create :list }
    end
  end
end
