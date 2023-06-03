FactoryBot.define do
  factory :user_login do
      sequence :email do |n|
        "user#{n}@gmail.com"
      end
      password { "nivetha#2" }
      password_confirmation {"nivetha#2"}
      sequence :user_name do |n|
        "User#{n}@2"
      end
      phone_no { "9363025833" }
      confirmed_at {Time.current}
      role { "customer" }
    end
end
