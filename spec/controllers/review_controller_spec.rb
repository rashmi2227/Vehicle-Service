require 'rails_helper'

RSpec.describe ReviewsController do

    let!(:customer_user) {create(:user_login ,  role: "customer", confirmed_at: Time.current)}
    let!(:employee_user) {create(:user_login ,  role: "employee", confirmed_at: Time.current)}
    let!(:admin_user) {create(:user_login ,  role: "admin", confirmed_at: Time.current)}
    let!(:vehicle) {create(:vehicle, user_id: customer_user.id)}
    # let!(:primary_technician) {create(:primary_technician, primary_technician_id: employee_user.id)}
    let!(:servicerequest) {create(:servicerequest, user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id)}

    describe "get/review #write" do

        context "accessing write" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :write
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :write
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :write
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :write
                    expect(response).to have_http_status(200)
                end
            end
        end
    end 

    describe "post/review #create" do

        context "accessing create" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    post :create , params: {review: {comment: "This is the comment dor the user", reviewable_id: employee_user.id, reviewable_type: "UserLogin", user_logins_id: customer_user.id}}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    post :create , params: {review: {comment: "This is the comment dor the user", reviewable_id: employee_user.id, reviewable_type: "UserLogin", user_logins_id: customer_user.id}}
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    post :create , params: {review: {comment: "This is the comment dor the user", reviewable_id: employee_user.id, reviewable_type: "UserLogin", user_logins_id: customer_user.id}}
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create , params: {review: {comment: "This is the comment dor the user", reviewable_id: employee_user.id, reviewable_type: "UserLogin", user_logins_id: customer_user.id}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as customer with valid params" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create , params: {review: {comment: "The employee had a very good behavouir to the customer", reviewable_id: employee_user.id, reviewable_type: "UserLogin", user_logins_id: customer_user.id}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as customer with valid params" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create , params: {review: {comment: "This is the comment dor the user", reviewable_id: employee_user.id, reviewable_type: "UserLogin", user_logins_id: customer_user.id}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as customer with invalid params" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create , params: {review: {comment: "This is the comment dor the user", reviewable_id: employee_user.id, reviewable_type: nil, user_logins_id: customer_user.id}}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end

            context "when user signed_in as customer with invalid params" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create , params: {review: {comment: "This is the comment do 84512525 #348#$ 54152user", reviewable_id: employee_user.id, reviewable_type: nil, user_logins_id: customer_user.id}}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end 

    describe "post/review #create" do

        context "accessing create" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    post :create , params: {review: {comment: "This is the comment dor the user", reviewable_id: servicerequest.id, reviewable_type: "servicerequest", user_logins_id: customer_user.id}}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    post :create , params: {review: {comment: "This is the comment dor the user", reviewable_id: servicerequest.id, reviewable_type: "Servicerequest", user_logins_id: customer_user.id}}
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    post :create , params: {review: {comment: "This is the comment dor the user", reviewable_id: servicerequest.id, reviewable_type: "Servicerequest", user_logins_id: customer_user.id}}
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create , params: {review: {comment: "This is the comment dor the user", reviewable_id: servicerequest.id, reviewable_type: "Servicerequest", user_logins_id: customer_user.id}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as customer with valid params" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create , params: {review: {comment: "The employee had a very good behavouir to the customer", reviewable_id: servicerequest.id, reviewable_type: "Servicerequest", user_logins_id: customer_user.id}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as customer with valid params" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create , params: {review: {comment: "This is the comment dor the user", reviewable_id: servicerequest.id, reviewable_type: "Servicerequest", user_logins_id: customer_user.id}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as customer with invalid params" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create , params: {review: {comment: "This is the comment dor the user", reviewable_id: servicerequest.id, reviewable_type: nil, user_logins_id: customer_user.id}}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end

            context "when user signed_in as customer with invalid params" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create , params: {review: {comment: "This is the comment do 84512525 #348#$ 54152user", reviewable_id: employee_user.id, reviewable_type: nil, user_logins_id: customer_user.id}}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end 

    describe "get/review #show" do

        context "accessing show" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :show
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :show
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :show
                    expect(response).to have_http_status(200)
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :show
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end
    
    describe "get/review #index" do

        context "accessing index" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :index
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :index
                    expect(response).to have_http_status(200)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :index
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :index
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end 
end
