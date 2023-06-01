require 'rails_helper'

RSpec.describe Api:: ServicerequestsController , type: :request do

    let!(:customer_user) {create(:user_login ,  role: "customer", confirmed_at: Time.current)}
    let!(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:employee_user) {create(:user_login ,  role: "employee", confirmed_at: Time.current)}
    let!(:employee_token) {create(:doorkeeper_access_token , resource_owner_id: employee_user.id)}

    let!(:employee_user_1) {create(:user_login ,  role: "employee", confirmed_at: Time.current)}
    let!(:employee_token_1) {create(:doorkeeper_access_token , resource_owner_id: employee_user_1.id)}

    let!(:admin_user) {create(:user_login ,  role: "admin", confirmed_at: Time.current)}
    let!(:admin_token) {create(:doorkeeper_access_token , resource_owner_id: admin_user.id)}

    let!(:vehicle) {create(:vehicle, user_id: customer_user.id)}
    let!(:servicerequest) {create(:servicerequest, user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id)}

    describe "get/vehicles #create" do
        context "accessing create method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    post "/api/service/add/#{vehicle.id}"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    post "/api/service/add/#{vehicle.id}", params: {access_token: customer_token.token, servicerequest:{ status: "Pending", start_date: "2023-05-12", end_date: "2023-05-17", primary_technician_id: employee_token_1.id, user_id: customer_user.id}}
                    expect(response).to have_http_status(200)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    post "/api/service/add/#{vehicle.id}", params: {access_token: employee_token.token, servicerequest:{ status: "Pending", start_date: "2023-05-12", end_date: "2023-05-17", primary_technician_id: employee_token_1.id, user_id: customer_user.id}}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    post "/api/service/add/#{vehicle.id}", params: {access_token: admin_token.token, servicerequest:{ status: "Pending", start_date: "2023-05-12", end_date: "2023-05-17", primary_technician_id: employee_token_1.id, user_id: customer_user.id}}
                    expect(response).to have_http_status(403)
                end
            end
        end
    end

    describe "get/vehicles #show" do
        context "accessing show method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/admin/viewservices"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/admin/viewservices", params: {access_token: customer_token.token, user_id: admin_user.id}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/admin/viewservices", params: {access_token: employee_token.token, user_id: admin_user.id}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/admin/viewservices", params: {access_token: admin_token.token, user_id: admin_user.id}
                    expect(response).to have_http_status(200)
                end
            end
        end
    end

    describe "get/vehicles #welcome" do
        context "accessing update method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    patch "/api/update/status/#{servicerequest.id}"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    patch "/api/update/status/#{servicerequest.id}", params: {access_token: customer_token.token, user_id: employee_user.id, servicerequest:{ status: "done"}}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    patch "/api/update/status/#{servicerequest.id}", params: {access_token: employee_token.token, user_id: employee_user.id, servicerequest: {status: "done"}}
                    expect(response).to have_http_status(202)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    patch "/api/update/status/#{servicerequest.id}", params: {access_token: admin_token.token, user_id: employee_user.id, servicerequest: {status: "done"}}
                    expect(response).to have_http_status(403)
                end
            end
        end
    end

    describe "get/vehicles #showbookedservice" do
        context "accessing showbookedservice method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/service/booked"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/service/booked", params: {access_token: customer_token.token, user_id: customer_user.id}
                    expect(response).to have_http_status(200)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/service/booked", params: {access_token: employee_token.token, user_id: customer_user.id}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/service/booked", params: {access_token: admin_token.token, user_id: customer_user.id}
                    expect(response).to have_http_status(403)
                end
            end
        end
    end

    describe "get/vehicles #index" do
        context "accessing index method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/view/all/service"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/view/all/service", params: {access_token: customer_token.token, user_id: employee_user.id}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/view/all/service", params: {access_token: employee_token.token, user_id: employee_user.id}
                    expect(response).to have_http_status(204)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/view/all/service", params: {access_token: admin_token.token, user_id: employee_user.id}
                    expect(response).to have_http_status(403)
                end
            end
        end
    end

    describe "get/vehicles #showpendingservice" do
        context "accessing showpendingservice method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/pending/service"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/pending/service", params: {access_token: customer_token.token, user_id: employee_user.id}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/pending/service", params: {access_token: employee_token.token, user_id: employee_user.id}
                    expect(response).to have_http_status(200)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/pending/service", params: {access_token: admin_token.token, user_id: employee_user.id}
                    expect(response).to have_http_status(403)
                end
            end
        end
    end

    describe "get/vehicles #checkserviceexisting" do
        context "accessing checkserviceexisting method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/service/add/#{vehicle.id}/check"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/service/add/#{vehicle.id}/check", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(204)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/service/add/#{vehicle.id}/check", params: {access_token: employee_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/service/add/#{vehicle.id}/check", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(403)
                end
            end
        end
    end

    describe "get/vehicles #completed_service" do
        context "accessing completed_service method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/service/completed"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                     get "/api/service/completed", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                     get "/api/service/completed", params: {access_token: employee_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                     get "/api/service/completed", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(204)
                end
            end
        end
    end
end