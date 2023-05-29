FactoryBot.define do
    factory :service_handler do
        vehicle_number { "TN 45 CB 3829"}
        employee_id { 1 }
        user_login
        servicerequest
        vehicle
    end
end
  