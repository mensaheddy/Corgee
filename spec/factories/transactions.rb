FactoryBot.define do
  factory :transaction do
    description { "my description" }
    amount { "12000" }
    classification { "income" }
    association :user, factory: :user
  end
end
