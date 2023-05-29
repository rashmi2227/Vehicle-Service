require 'rails_helper'

RSpec.describe EmployeesController do

    let!(:customer_user) {create(:user_login ,  role: "customer")}
    let!(:employee_user) {create(:user_login ,  role: "employee")}
    let!(:admin_user) {create(:user_login ,  role: "admin")}
    let!(:vehicle) {create(:vehicle, user_id: customer_user.id)}
    let!(:servicerequest) {create(:servicerequest, user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id)}

    describe "get/employee #welcome" do
        context "accessing welcome" do
            context "when user not signed_in" do
                it "redirects to login page" do
                    get :welcome
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :welcome
                    expect(response).to have_http_status(200)
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :welcome
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in customer_user
                    get :welcome
                    expect(response).to redirect_to root_path
                end
            end
        end
    end

    describe "post/admin #checkservice" do
        context "accessing checkservice" do
            context "when user not signed_in" do
                it "redirects to login page" do
                    post :checkservice, params:{ servicerequest:{id: servicerequest.id}}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    post :checkservice, params:{ servicerequest:{id: servicerequest.id}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :checkservice, params:{ servicerequest:{id: servicerequest.id}}
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in customer_user
                    post :checkservice, params:{ servicerequest:{id: servicerequest.id}}
                    expect(response).to redirect_to root_path
                end
            end
        end
    end

    describe "get/admin #updatestatus" do
        context "accessing updatestatus" do
            context "when user not signed_in" do
                it "redirects to login page" do
                    get :updatestatus
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :updatestatus
                    expect(response).to have_http_status(200)
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :updatestatus
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in customer_user
                    get :updatestatus
                    expect(response).to redirect_to root_path
                end
            end
        end
    end

    describe "get/admin #vehicle" do
        context "accessing vehicle" do
            context "when user not signed_in" do
                it "redirects to login page" do
                    get :vehicle
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :vehicle
                    expect(response).to have_http_status(200)
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :vehicle
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in customer_user
                    get :vehicle
                    expect(response).to redirect_to root_path
                end
            end
        end
    end

    describe "get/admin #error" do
        context "accessing error page" do
            context "when user not signed_in" do
                it "redirects to login page" do
                    get :error
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :error
                    expect(response).to have_http_status(200)
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :error
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in customer_user
                    get :error
                    expect(response).to redirect_to root_path
                end
            end
        end
    end
end