require 'rails_helper'

RSpec.describe Api::VehiclesController , type: :request do

    let!(:customer_user) {create(:user_login ,  role: "customer")}
    let!(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:employee_user) {create(:user_login ,  role: "employee")}
    let!(:employee_token) {create(:doorkeeper_access_token , resource_owner_id: employee_user.id)}

    let!(:admin_user) {create(:user_login ,  role: "admin")}
    let!(:admin_token) {create(:doorkeeper_access_token , resource_owner_id: admin_user.id)}

    let!(:vehicle) {create(:vehicle, user_id: customer_user.id)}

    describe "get/vehicles #welcome" do
        context "When user not signed in" do
            it "redirects to login page" do
                get "/api/bike/show"
                expect(response).to have_http_status(401)
            end
        end

        context "When signed in as customer" do
            it "redirects to user profile page" do
                get "/api/bike/show", params: {access_token: customer_token.token, user_id: customer_user.id}
                expect(response).to have_http_status(200)
            end
        end

        context "When signed in as employee" do
            it "redirects to users index" do
                get "/api/bike/show", params: {access_token: employee_token.token}
                expect(response).to have_http_status(403)
            end
        end

        context "When signed in as admin" do
            it "redirects to sub-vehicles profile index" do
                get "/api/bike/show", params: {access_token: admin_token.token}
                expect(response).to have_http_status(403)
            end
        end
    end

    describe "get/vehicles #welcome" do
        context "When user not signed in" do
            it "redirects to login page" do
                get "/api/vehicles/create"
                expect(response).to have_http_status(401)
            end
        end

        context "When signed in as customer" do
            it "redirects to user profile page" do
                get "/api/vehicles/create", params: {access_token: customer_token.token, user_id: customer_user.id,  vehicle: {vehicle_modal: "SUV", color: "crimson red", purchase_date: "2023-09-24", vehicle_number: "TN 37 CB 3829", make: "Benz", user_id: customer_user.id}}
                expect(response).to have_http_status(201)
            end
        end

        context "When signed in as employee" do
            it "redirects to users index" do
                get "/api/vehicles/create", params: {access_token: admin_token.token, user_id: customer_user.id, vehicle: {vehicle_modal: "SUV", color: "crimson red", purchase_date: "2023-09-24", vehicle_number: "TN 37 CB 3829", make: "Benz", user_id: customer_user.id}}
                expect(response).to have_http_status(403)
            end
        end

        context "When signed in as admin" do
            it "redirects to sub-vehicles profile index" do
                get "/api/vehicles/create", params: {access_token: employee_token.token, user_id: customer_user.id, vehicle: {vehicle_modal: "SUV", color: "crimson red", purchase_date: "2023-09-24", vehicle_number: "TN 37 CB 3829", make: "Benz", user_id: customer_user.id}}
                expect(response).to have_http_status(403)
            end
        end
    end

    describe "patch/vehicles #welcome" do
        context "When user not signed in" do
            it "redirects to login page" do
                patch "/api/vehicles/#{vehicle.id}"
                expect(response).to have_http_status(401)
            end
        end

        context "When signed in as customer" do
            it "redirects to user profile page" do
                patch "/api/vehicles/#{vehicle.id}", params: {access_token: customer_token.token, vehicle: {vehicle_modal: "SUV", color: "crimson red", purchase_date: "2023-09-24", vehicle_number: "TN 37 CB 3829", make: "Benz"}}
                expect(response).to have_http_status(202)
            end
        end

        context "When signed in as employee" do
            it "redirects to users index" do
                patch "/api/vehicles/#{vehicle.id}", params: {access_token: admin_token.token,  vehicle: {vehicle_modal: "SUV", color: "crimson red", purchase_date: "2023-09-24", vehicle_number: "TN 37 CB 3829", make: "Benz"}}
                expect(response).to have_http_status(403)
            end
        end

        context "When signed in as admin" do
            it "redirects to sub-vehicles profile index" do
                patch "/api/vehicles/#{vehicle.id}", params: {access_token: employee_token.token,  vehicle: {vehicle_modal: "SUV", color: "crimson red", purchase_date: "2023-09-24", vehicle_number: "TN 37 CB 3829", make: "Benz"}}
                expect(response).to have_http_status(403)
            end
        end
    end

    describe "patch/vehicles #welcome" do
        context "When user not signed in" do
            it "redirects to login page" do
                post "/api/employees/check/vehicle"
                expect(response).to have_http_status(401)
            end
        end

        context "When signed in as customer" do
            it "redirects to user profile page" do
                post "/api/employees/check/vehicle", params: {access_token: customer_token.token, vehicle: {vehicle_number: "TN 37 CB 3829"}}
                expect(response).to have_http_status(403)
            end
        end

        context "When signed in as employee" do
            it "redirects to users index" do
                post"/api/employees/check/vehicle", params: {access_token: admin_token.token,  vehicle: {vehicle_number: "TN 37 CB 3829"}}
                expect(response).to have_http_status(403)
            end
        end

        context "When signed in as admin" do
            it "redirects to sub-vehicles profile index" do
                post "/api/employees/check/vehicle", params: {access_token: employee_token.token,  vehicle: {vehicle_number: "TN 37 CB 3829"}}
                expect(response).to have_http_status(204)
            end
        end
    end

    describe "patch/vehicles #welcome" do
        context "When user not signed in" do
            it "redirects to login page" do
                delete "/api/vehicle/delete/#{vehicle.id}"
                expect(response).to have_http_status(401)
            end
        end

        context "When signed in as customer" do
            it "redirects to user profile page" do
                delete "/api/vehicle/delete/#{vehicle.id}", params: {access_token: customer_token.token}
                expect(response).to have_http_status(200)
            end
        end

        context "When signed in as employee" do
            it "redirects to users index" do
                delete "/api/vehicle/delete/#{vehicle.id}", params: {access_token: admin_token.token}
                expect(response).to have_http_status(403)
            end
        end

        context "When signed in as admin" do
            it "redirects to sub-vehicles profile index" do
                delete "/api/vehicle/delete/#{vehicle.id}", params: {access_token: employee_token.token}
                expect(response).to have_http_status(403)
            end
        end
    end

    describe "patch/vehicles #welcome" do
        context "When user not signed in" do
            it "redirects to login page" do
                get "/api/vehicle/details/#{vehicle.id}"
                expect(response).to have_http_status(401)
            end
        end

        context "When signed in as customer" do
            it "redirects to user profile page" do
                get "/api/vehicle/details/#{vehicle.id}", params: {access_token: customer_token.token}
                expect(response).to have_http_status(403)
            end
        end

        context "When signed in as employee" do
            it "redirects to users index" do
                get "/api/vehicle/details/#{vehicle.id}", params: {access_token: admin_token.token}
                expect(response).to have_http_status(403)
            end
        end

        context "When signed in as admin" do
            it "redirects to sub-vehicles profile index" do
                get "/api/vehicle/details/#{vehicle.id}", params: {access_token: employee_token.token}
                expect(response).to have_http_status(200)
            end
        end
    end
end