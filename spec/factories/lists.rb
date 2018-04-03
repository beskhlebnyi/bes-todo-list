FactoryBot.define do
  factory :list do
    sequence(:title ) { |n| "Some #{n} Title" }
  end
end
