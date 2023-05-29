FactoryBot.define do
    factory :vehicle do
        vehicle_modal { "sedan" }
        make { "audi" }
        # sequence :vehicle_number do |n|
        #     "TN 57 CB 20#{n}"
        #   end
        vehicle_number { "TN 87 CB 2342" }
        color { "silver" }
        purchase_date { "2023-05-24" }
        user_login
    end
end
  