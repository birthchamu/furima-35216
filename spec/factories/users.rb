FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {Faker::Internet.free_email}
    password              {'123Test'}
    password_confirmation {password}
    first_name            {'一郎'}
    family_name           {'鈴木'}
    first_name_kana       {'イチロー'}
    family_name_kana      {'スズキ'}
    date_of_birth         {'1973-10-22'}
  end
end