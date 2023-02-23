FactoryBot.define do
  factory :subscription do
    customer
    tea
    title { Faker::Subscription.plan }
    price { Faker::Number.within(range: 900..3000) }
    status { "active" }
    frequency { Faker::Subscription.subscription_term }
  end
end
