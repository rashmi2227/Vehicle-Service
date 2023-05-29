FactoryBot.define do
    factory :payment do
        amount { "5000" }
        payment_status {"unpaid"}
        servicerequest
        vehicle
        user_login
    end
end
  