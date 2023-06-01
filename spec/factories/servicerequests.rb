FactoryBot.define do
    factory :servicerequest do
        status { "pending"}
        start_date { "2023/05/24"}
        end_date {"2023-05-27"}
        primary_technician_id { 78 }
        user_login
        vehicle
    end
end
  