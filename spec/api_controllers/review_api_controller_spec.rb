require 'rails_helper'

RSpec.describe Api::ReviewsController , type: :request do

    let!(:customer_user) {create(:user_login ,  role: "customer", confirmed_at: Time.current)}
    let!(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:employee_user) {create(:user_login ,  role: "employee", confirmed_at: Time.current)}
    let!(:employee_token) {create(:doorkeeper_access_token , resource_owner_id: employee_user.id)}

    let!(:admin_user) {create(:user_login ,  role: "admin", confirmed_at: Time.current)}
    let!(:admin_token) {create(:doorkeeper_access_token , resource_owner_id: admin_user.id)}

    let!(:vehicle) {create(:vehicle, user_id: customer_user.id)}
    # let!(:primary_technician) {create(:primary_technician, primary_technician_id: employee_user.id)}
    let!(:servicerequest) {create(:servicerequest, user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id)}
    let!(:review) {create(:review, reviewable_id: servicerequest.id, user_logins_id: customer_user.id, reviewable_type: "Servicerequest", comment: "This is comment")}

    describe "get/vehicles #create" do
        context "acessing create method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    post "/api/reviews/add"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    post "/api/reviews/add", params: {access_token: customer_token.token, review: {reviewable_id: customer_user.user_name, reviewable_type: "UserLogin", comment: "Customer service was really very good"}}
                    expect(response).to have_http_status(201)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    post "/api/reviews/add", params: {access_token: admin_token.token, review: {reviewable_id: customer_user.user_name, reviewable_type: "UserLogin", comment: "Customer service was really very good"}}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    post "/api/reviews/add", params: {access_token: employee_token.token, review: {reviewable_id: customer_user.user_name, reviewable_type: "UserLogin", comment: "Customer service was really very good"}}
                    expect(response).to have_http_status(403)
                end
            end
        end
    end

    describe "get/vehicles #create" do
        context "acessing create method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    post "/api/reviews/add"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    post "/api/reviews/add", params: {access_token: customer_token.token, review: {reviewable_id: servicerequest.id, reviewable_type: "Servicerequest", comment: "Customer service was really very good"}}
                    expect(response).to have_http_status(201)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    post "/api/reviews/add", params: {access_token: admin_token.token, review: {reviewable_id: servicerequest.id, reviewable_type: "Servicerequest", comment: "Customer service was really very good"}}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    post "/api/reviews/add", params: {access_token: employee_token.token, review: {reviewable_id: servicerequest.id, reviewable_type: "Servicerequest", comment: "Customer service was really very good"}}
                    expect(response).to have_http_status(403)
                end
            end
        end
    end


    describe "get/vehicles #show" do
        context "acessing show method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/view/reviews"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/view/reviews", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/view/reviews", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/view/reviews", params: {access_token: employee_token.token, }
                    expect(response).to have_http_status(204)
                end
            end
        end
    end

    describe "get/vehicles #index" do
        context "acessing index method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/view/reviews"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/view/reviews", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/view/reviews", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/view/reviews", params: {access_token: employee_token.token, }
                    expect(response).to have_http_status(204)
                end
            end
        end
    end

    describe "get/vehicles #index" do
        context "acessing index method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    delete "/api/reviews/delete/#{review.id}"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    delete "/api/reviews/delete/#{review.id}", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    delete "/api/reviews/delete/#{review.id}", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(200)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    delete "/api/reviews/delete/#{review.id}", params: {access_token: employee_token.token, }
                    expect(response).to have_http_status(403)
                end
            end
        end
    end

    describe "get/vehicles #user_reviews" do
        context "acessing user_reviews method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/reviews/user"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/reviews/user", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/reviews/user", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(204)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/reviews/user", params: {access_token: employee_token.token, }
                    expect(response).to have_http_status(403)
                end
            end
        end
    end

    describe "get/vehicles #user_reviews" do
        context "acessing user_reviews method" do
            context "When user not signed in" do
                it "redirects to login page" do
                    get "/api/reviews/service"
                    expect(response).to have_http_status(401)
                end
            end

            context "When signed in as customer" do
                it "redirects to user profile page" do
                    get "/api/reviews/service", params: {access_token: customer_token.token}
                    expect(response).to have_http_status(403)
                end
            end

            context "When signed in as employee" do
                it "redirects to users index" do
                    get "/api/reviews/service", params: {access_token: admin_token.token}
                    expect(response).to have_http_status(200)
                end
            end

            context "When signed in as admin" do
                it "redirects to sub-vehicles profile index" do
                    get "/api/reviews/service", params: {access_token: employee_token.token, }
                    expect(response).to have_http_status(403)
                end
            end
        end
    end
end