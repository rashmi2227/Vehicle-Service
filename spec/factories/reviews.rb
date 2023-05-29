require 'faker'

FactoryBot.define do
    factory :review do
        comment { Faker::Lorem.characters(number: 255) }

        trait :within_character_limit do
            comment { Faker::Lorem.characters(number: 255) }
        end

        for_user

        trait :for_user do 
            association :reviewable, factory: :user_login
        end

        trait :for_servicerequest do 
            association :reviewable, factory: :servicerequest
        end
    end
end