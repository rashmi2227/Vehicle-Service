require 'rails_helper'

RSpec.describe AdminsController do

    let!(:customer_user) {create(:user_login ,  role: "customer", confirmed_at: Time.current)}
    let!(:employee_user) {create(:user_login ,  role: "employee", confirmed_at: Time.current)}
    let!(:admin_user) {create(:user_login ,  role: "admin", confirmed_at: Time.current)}
    let!(:vehicle) {create(:vehicle, user_id: customer_user.id)}
    let!(:servicerequest) {create(:servicerequest, user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id)}

    describe "get/admin #welcome" do
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
                    expect(response).to redirect_to root_path
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :welcome
                    expect(response).to have_http_status(200)
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

    describe "get/admin #employee" do
        context "accessing employee" do
            context "when user not signed_in" do
                it "redirects to login page" do
                    get :employee
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :employee
                    expect(response).to redirect_to root_path
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :employee
                    expect(response).to have_http_status(200)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in customer_user
                    get :employee
                    expect(response).to redirect_to root_path
                end
            end
        end
    end


    describe "get/admin #admin" do
        context "accessing admin" do
            context "when user not signed_in" do
                it "redirects to login page" do
                    get :admin
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :admin
                    expect(response).to redirect_to root_path
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :admin
                    expect(response).to have_http_status(200)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in customer_user
                    get :admin
                    expect(response).to redirect_to root_path
                end
            end
        end
    end

    describe "get/admin #assign" do
        context "accessing assing" do
            context "when user not signed_in" do
                it "redirects to login page" do
                    get :assign, params:{ id: servicerequest.id}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :assign, params:{ id: servicerequest.id}
                    expect(response).to redirect_to root_path
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :assign, params:{ id: servicerequest.id}
                    expect(response).to have_http_status(200)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in customer_user
                    get :assign, params:{ id: servicerequest.id}
                    expect(response).to redirect_to root_path
                end
            end
        end
    end

    describe "get/admin #check" do
        context "accessing check" do
            context "when user not signed_in" do
                it "redirects to login page" do
                    get :check, params:{ id: servicerequest.id}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :check, params:{ id: servicerequest.id}
                    expect(response).to redirect_to root_path
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :check, params:{ id: servicerequest.id}
                    expect(response).to have_http_status(302)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in customer_user
                    get :check, params:{ id: servicerequest.id}
                    expect(response).to redirect_to root_path
                end
            end
        end
    end

    describe "post/admin #createmployee" do
        context "accessing check" do
            context "when user not signed_in" do
                it "redirects to login page" do
                    post :createmployee, params:{ user_login: {user_name: "Employee#1", email: "employee#1@gmail.com", password: "employee#1#2", password_confirmation: "employee#1#2", role: "employee", phone_no: "5623278628"}}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    post :createmployee, params:{ user_login: {user_name: "Employee#1", email: "employee#1@gmail.com", password: "employee#1#2", password_confirmation: "employee#1#2", role: "employee", phone_no: "5623278628"}}
                    expect(response).to redirect_to root_path
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :createmployee, params:{ user_login: {user_name: "Employee#1", email: "employee#1@gmail.com", password: "employee#1#2", password_confirmation: "employee#1#2", role: "employee", phone_no: "5623278628"}}
                    expect(response).to have_http_status(302)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in customer_user
                    post :createmployee, params:{ user_login: {user_name: "Employee#1", email: "employee#1@gmail.com", password: "employee#1#2", password_confirmation: "employee#1#2", role: "employee", phone_no: "5623278628"}}
                    expect(response).to redirect_to root_path
                end
            end

            context "when signed_in as admin with valid params" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :createmployee, params:{ user_login: {user_name: "Employee#1", email: "employee#1@gmail.com", password: "employee#1#2", password_confirmation: "employee#1#2", role: "employee", phone_no: "5623278628"}}
                    expect(response).to have_http_status(302)
                end
            end
    
            context "when signed_in as employee with valid params" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :createmployee, params:{ user_login: {user_name: "Employee#2", email: "employee#2@gmail.com", password: "employee#2#2", password_confirmation: "employee#2#2", role: "employee", phone_no: "5623489628"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when signed_in as admin with invalid params" do
                it "redirects to lo have_http_status(200)gin page" do
                    sign_in admin_user
                    post :createmployee, params:{ user_login: {user_name: "employee1", email: "employee#1@gmail.com", password: "employee#2", password_confirmation: "employee#1#2", role: "employee", phone_no: "5623278628"}}
                    expect(response).to redirect_to admin_welcome_path
                end
            end
    
            context "when signed_in as employee with invalid params" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :createmployee, params:{ user_login: {user_name: "employee2", email: "employee#2@gmail.com", password: "employee#2#2", password_confirmation: "employee#2#2", role: "employee", phone_no: "5623489628"}}
                    expect(response).to redirect_to admin_welcome_path
                end
            end
        end
    end

    describe "post/admin #createadmin" do
        context "accessing check" do
            context "when user not signed_in" do
                it "redirects to login page" do
                    post :createadmin, params:{ user_login: {user_name: "Admin#1", email: "admin#1@gmail.com", password: "admin#1#2", password_confirmation: "admin#1#2", role: "admin", phone_no: "5622228628"}}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    post :createadmin, params:{ user_login: {user_name: "Admin#1", email: "admin#1@gmail.com", password: "admin#1#2", password_confirmation: "admin#1#2", role: "admin", phone_no: "5622846628"}}
                    expect(response).to redirect_to root_path
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :createadmin, params:{ user_login: {user_name: "Admin#1", email: "admin#1@gmail.com", password: "admin#1#2", password_confirmation: "admin#1#2", role: "admin", phone_no: "5623211128"}}
                    expect(response).to have_http_status(302)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in customer_user
                    post :createmployee, params:{ user_login: {user_name: "Admin#1", email: "admin#1@gmail.com", password: "admin#1#2", password_confirmation: "admin#1#2", role: "admin", phone_no: "5963578628"}}
                    expect(response).to redirect_to root_path
                end
            end

            context "when signed_in as admin with valid params" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :createmployee, params:{ user_login: {user_name: nil, email: "admin#1@gmail.com", password: "amdin#1#2", password_confirmation: "amdin#1#2", role: "admin", phone_no: "5627412628"}}
                    expect(response).to have_http_status(302)
                end
            end
    
            context "when signed_in as employee with valid params" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :createadmin, params:{ user_login: {user_name: "Admin#2", email: "admin#2", password: "admin#2#2", password_confirmation: "admin#2", role: "admin", phone_no: "56238221428"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when signed_in as admin with invalid params" do
                it "redirects to lo have_http_status(200)gin page" do
                    sign_in admin_user
                    post :createadmin, params:{ user_login: {user_name: "adm1", email: "admin#1@gmail.com", password: "admin#2", password_confirmation: "admin#1#2", role: "admin", phone_no: "5627412628"}}
                    expect(response).to redirect_to admin_welcome_path
                end
            end
    
            context "when signed_in as employee with invalid params" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :createadmin, params:{ user_login: {user_name: "admin2", email: "admin#2@gmail.com", password: "admin#2#2", password_confirmation: "admin#2#2", role: "admin", phone_no: "5623489628"}}
                    expect(response).to redirect_to admin_welcome_path
                end
            end
        end
    end

    describe "get/admin #assignservice" do
        context "accessing check" do
            context "when user not signed_in" do
                it "redirects to login page" do
                    get :assignservice
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :assignservice
                    expect(response).to redirect_to root_path
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :assignservice
                    expect(response).to have_http_status(200)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in customer_user
                    get :assignservice
                    expect(response).to redirect_to root_path
                end
            end
        end
    end

    describe "get/admin #checkservice" do
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
                    expect(response).to redirect_to root_path
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :checkservice, params:{ servicerequest:{id: servicerequest.id}}
                    expect(response).to have_http_status(302)
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
end