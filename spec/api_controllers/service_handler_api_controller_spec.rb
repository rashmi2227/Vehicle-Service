require 'rails_helper'

RSpec.describe Api:: ServicerequestsController , type: :request do

    let!(:customer_user) {create(:user_login ,  role: "customer", confirmed_at: Time.current)}
    let!(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:employee_user) {create(:user_login ,  role: "employee", confirmed_at: Time.current)}
    let!(:employee_token) {create(:doorkeeper_access_token , resource_owner_id: employee_user.id)}

    let!(:employee_user_1) {create(:user_login ,  role: "employee", confirmed_at: Time.current)}
    let!(:employee_token_1) {create(:doorkeeper_access_token , resource_owner_id: employee_user_1.id)}

    let!(:employee_user_2) {create(:user_login ,  role: "employee", confirmed_at: Time.current)}
    let!(:employee_token_2) {create(:doorkeeper_access_token , resource_owner_id: employee_user_2.id)}

    let!(:admin_user) {create(:user_login ,  role: "admin", confirmed_at: Time.current)}
    let!(:admin_token) {create(:doorkeeper_access_token , resource_owner_id: admin_user.id)}

    let!(:vehicle) {create(:vehicle, user_id: customer_user.id)}
    let!(:servicerequest) {create(:servicerequest, user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id)}
    # let!(:service_handler) {create(:service_handler, user_id: customer_user.id, vehicle_id: vehicle.id,servicerequest_id: servicerequest.id)}

    describe "get/vehicles #create" do
        context "accessing create page" do
            context "When user not signed in" do
                it "redirects to login page" do
                    post "/api/serviceassigned/#{servicerequest.id}"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    post "/api/serviceassigned/#{servicerequest.id}", params: {access_token: customer_token.token, user_id: customer_user.id, primary_technician_id: employee_user_1.id, employee_id: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: vehicle.vehicle_number}
                    expect(response).to have_http_status(404)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    post "/api/serviceassigned/#{servicerequest.id}", params: {access_token: employee_token.token, user_id: customer_user.id, primary_technician_id: employee_user_1.id, employee_id: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: vehicle.vehicle_number}
                    expect(response).to have_http_status(404)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    post "/api/serviceassigned/#{servicerequest.id}", params: {access_token: admin_token.token, user_id: customer_user.id, primary_technician_id: employee_user_1.id, employee_id: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: vehicle.vehicle_number}
                    expect(response).to have_http_status(201)
                end
            end
        end
    end

    describe "get/vehicles #index" do
        context "accessing index page" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/serviceassigned/show"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/serviceassigned/show", params: {access_token: customer_token.token, user_id: customer_user.id, primary_technician_id: employee_user_1.id, employee_id: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: vehicle.vehicle_number}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/serviceassigned/show" , params: {access_token: employee_token.token, user_id: customer_user.id, primary_technician_id: employee_user_1.id, employee_id: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: vehicle.vehicle_number}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/serviceassigned/show", params: {access_token: admin_token.token, user_id: customer_user.id, primary_technician_id: employee_user_1.id, employee_id: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: vehicle.vehicle_number}
                    expect(response).to have_http_status(204)
                end
            end
        end
    end

    # describe "get/vehicles #update" do
    #     context "accessing update page" do
    #         context "When user not signed in" do
    #             it "redirects to login page" do
    #                 get "/api/edithandlers/:id"
    #                 expect(response).to have_http_status(401)
    #             end
    #         end

    #         context "When signed in as customer" do
    #             it "redirects to user profile page" do
    #                 get "/api/edithandlers/#{service_handler.id}", params: {access_token: customer_token.token,  primary_technician_id: employee_user_1.id, employee_id: employee_user_2.id, service_handler: {employee_id: employee_user_2.id, primary_technician_id: employee_user_1.id}}
    #                 expect(response).to have_http_status(403)
    #             end
    #         end

    #         context "When signed in as employee" do
    #             it "redirects to users index" do
    #                 get "/api/edithandlers/#{service_handler.id}" , params: {access_token: employee_token.token, primary_technician_id: employee_user_1.id, employee_id: employee_user_2.id, service_handler: {employee_id: employee_user_2.id, primary_technician_id: employee_user_1.id}}
    #                 expect(response).to have_http_status(403)
    #             end
    #         end

    #         context "When signed in as admin" do
    #             it "redirects to sub-vehicles profile index" do
    #                 get "/api/edithandlers/#{service_handler.id}", params: {access_token: admin_token.token, primary_technician_id: employee_user_1.id, employee_id: employee_user_2.id, service_handler: {employee_id: employee_user_2.id, primary_technician_id: employee_user_1.id}}
    #                 expect(response).to have_http_status(204)
    #             end
    #         end
    #     end
    # end
end