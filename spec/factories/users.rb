FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    users_nickname          { Faker::Name.name }
    email                   { Faker::Internet.email }
    password                { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation   { password }
    first_name              { person.first.kanji }
    last_name               { person.last.kanji }
    first_name_kana         { person.first.katakana }
    last_name_kana          { person.last.katakana }
    birthday                { Faker::Date.backward }
  end
end
