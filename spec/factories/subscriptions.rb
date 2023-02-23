FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    price { 1 }
    status { "MyString" }
    frequency { "MyString" }
    customer { nil }
    tea { nil }
  end
end
