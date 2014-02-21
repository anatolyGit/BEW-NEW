# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :login do |n|
      "user_#{n}"
    end
    password 'p@ssw0rd'
    password_confirmation 'p@ssw0rd'
  end
end
