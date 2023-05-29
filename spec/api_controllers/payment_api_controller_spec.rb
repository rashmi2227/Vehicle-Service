require 'rails_helper'

RSpec.describe Api::PaymentsController , type: :request do

    let!(:customer_user) {create(:user_login ,  role: "customer")}
    let!(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:employee_user) {create(:user_login ,  role: "employee")}
    let!(:employee_token) {create(:doorkeeper_access_token , resource_owner_id: employee_user.id)}

    let!(:admin_user) {create(:user_login ,  role: "admin")}
    let!(:admin_token) {create(:doorkeeper_access_token , resource_owner_id: admin_user.id)}

    let!(:vehicle) {create(:vehicle, user_id: customer_user.id)}
    # let!(:primary_technician) {create(:primary_technician, primary_technician_id: employee_user.id)}
    let!(:servicerequest) {create(:servicerequest, user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id)}
    let!(:payment) {create(:payment, servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, user_id: customer_user.id, amount: "9855", payment_status: "unpaid")}

    describe "get/payment #create" do
        context "accessing create method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    post "/api/payment/add/#{servicerequest.id}"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    post "/api/payment/add/#{servicerequest.id}", params: {access_token: admin_token.token, user_id: customer_user.id, vehicle_id: vehicle.id, servicerequest_id: servicerequest.id, payment:{ amount: "8546", user_id: customer_user.id, vehicle_id: vehicle.id, servicerequest_id: servicerequest.id}}
                    expect(response).to have_http_status(200)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    post "/api/payment/add/#{servicerequest.id}", params: {access_token: employee_token.token, user_id: customer_user.id, vehicle_id: vehicle.id, servicerequest_id: servicerequest.id, payment: { amount: "9226", user_id: customer_user.id, vehicle_id: vehicle.id, servicerequest_id: servicerequest.id}}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    post "/api/payment/add/#{servicerequest.id}", params: {access_token: customer_token.token, user_id: customer_user.id, vehicle_id: vehicle.id, servicerequest_id: servicerequest.id, payment: { amount: "8514", user_id: customer_user.id, vehicle_id: vehicle.id, servicerequest_id: servicerequest.id}}
                    expect(response).to have_http_status(403)
                end
            end
        end
    end

    describe "get/payment #index" do
        context "accessing index method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/payments/show"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/payments/show", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/payments/show", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(200)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/payments/show", params: {access_token: employee_token.token} 
                    expect(response).to have_http_status(403)
                end
            end
        end
    end

    describe "get/payment #index" do
        context "accessing index method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/payments/all"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/payments/all", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(200)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/payments/all", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/payments/all", params: {access_token: employee_token.token} 
                    expect(response).to have_http_status(403)
                end
            end
        end
    end
    
    describe "get/payment #update" do
        context "accessing update method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    patch "/api/user/payment/pay/#{payment.id}"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    patch "/api/user/payment/pay/#{payment.id}", params: {access_token: customer_token.token, payment: { payment_status: "paid"}}
                    expect(response).to have_http_status(202)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    patch "/api/user/payment/pay/#{payment.id}", params: {access_token: admin_token.token, payment: { payment_status: "paid"}}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    patch "/api/user/payment/pay/#{payment.id}", params: {access_token: employee_token.token, payment: {payment_status: "paid"}} 
                    expect(response).to have_http_status(403)
                end
            end
        end
    end

    describe "get/payment #update" do
        context "accessing update method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    delete "/api/payments/delete/#{payment.id}"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    delete "/api/payments/delete/#{payment.id}", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    delete "/api/payments/delete/#{payment.id}", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(200)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    delete "/api/payments/delete/#{payment.id}", params: {access_token: employee_token.token} 
                    expect(response).to have_http_status(403)
                end
            end
        end
    end
end