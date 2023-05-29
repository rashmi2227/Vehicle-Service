require 'rails_helper'

RSpec.describe Api::UserLoginsController , type: :request do

    let!(:customer_user) {create(:user_login ,  role: "customer")}
    let!(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:employee_user) {create(:user_login ,  role: "employee")}
    let!(:employee_token) {create(:doorkeeper_access_token , resource_owner_id: employee_user.id)}

    let!(:admin_user) {create(:user_login ,  role: "admin")}
    let!(:admin_token) {create(:doorkeeper_access_token , resource_owner_id: admin_user.id)}

    describe "get/user_logins #welcome" do
        context "accessing  method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/view/all/employees"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/view/all/employees", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/view/all/employees", params: {access_token: employee_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/view/all/employees", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(200)
                end
            end
        end
    end

    describe "get/user_logins #welcome" do
        context "accessing  method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/view/admins"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/view/admins", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/view/admins", params: {access_token: employee_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/view/admins", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(200)
                end
            end
        end
    end

    describe "get/user_logins #welcome" do
        context "accessing  method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/view/customers"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/view/customers", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/view/customers", params: {access_token: employee_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/view/customers", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(200)
                end
            end
        end
    end
end