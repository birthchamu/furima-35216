FactoryBot.define do
  factory :address do
    postal_number { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipality  { Faker::Address.city }
    address1      { Faker::Address.street_address }
    address2      { Faker::Address.secondary_address }
    phone_number  { Faker::Number.between(from: 1, to: 99_999_999_999) }
    token         { 'tok_abcdefghijk00000000000000000' }
  end
end
