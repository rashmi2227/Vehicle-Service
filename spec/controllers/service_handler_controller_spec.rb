require 'rails_helper'

RSpec.describe ServiceHandlersController do

    let!(:customer_user) {create(:user_login ,  role: "customer", confirmed_at: Time.current)}
    let!(:employee_user) {create(:user_login ,  role: "employee", confirmed_at: Time.current)}
    let!(:employee_user_1) {create(:user_login ,  role: "employee", confirmed_at: Time.current)}
    let!(:employee_user_2) {create(:user_login ,  role: "employee", confirmed_at: Time.current)}
    let!(:admin_user) {create(:user_login ,  role: "admin", confirmed_at: Time.current)}
    let!(:vehicle) {create(:vehicle, user_id: customer_user.id)}
    # let!(:primary_technician) {create(:primary_technician, primary_technician_id: employee_user.id)}
    let!(:servicerequest) {create(:servicerequest, user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user_1.id)}
    # let!(:service_handler) {create(:service_handler, employee_id: employee_user_2.id, vehicle_id: vehicle.id, user_id: customer_user.id, servicerequest_id: servicerequest.id)}

    describe "post/service_handler #create" do

        context "accessing create" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    post :create, params: {id: servicerequest.id, servicerequest: {primary_technician_id: employee_user_1.id}, servicehandler:{user_id: customer_user.id, subhandler: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: "TN 90 SJ 3720", servicerequest_id: servicerequest.id}}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user not signed_in" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :create, params: {id: servicerequest.id, servicerequest: {primary_technician_id: employee_user_1.id}, servicehandler:{user_id: customer_user.id, subhandler: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: "TN 90 SJ 3720", servicerequest_id: servicerequest.id}}
                    expect(response).to redirect_to serviceassigned_show_path
                end
            end

            context "when user not signed_in" do
                it "redirects to login page" do
                    sign_in employee_user
                    post :create, params: {id: servicerequest.id, servicerequest: {primary_technician_id: employee_user_1.id}, servicehandler:{user_id: customer_user.id, subhandler: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: "TN 90 SJ 3720", servicerequest_id: servicerequest.id}}
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user not signed_in" do
                it "redirects to login page" do
                    sign_in customer_user
                    post :create, params: {id: servicerequest.id, servicerequest: {primary_technician_id: employee_user_1.id}, servicehandler:{user_id: customer_user.id, subhandler: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: "TN 90 SJ 3720", servicerequest_id: servicerequest.id}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user not signed_in with valid params" do
                it "redirects to login page" do
                    sign_in customer_user
                    post :create, params: {id: servicerequest.id, servicerequest: {primary_technician_id: employee_user_1.id}, servicehandler:{user_id: customer_user.id, subhandler: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: "TN 90 SJ 3720", servicerequest_id: servicerequest.id}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user not signed_in with valid params" do
                it "redirects to login page" do
                    sign_in customer_user
                    post :create, params: {id: servicerequest.id, servicerequest: {primary_technician_id: employee_user_1.id}, servicehandler:{user_id: customer_user.id, subhandler: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: "TN 90 SJ 3720", servicerequest_id: servicerequest.id}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user not signed_in with invalid params" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :create, params: {id: servicerequest.id, servicerequest: {primary_technician_id: employee_user_1.id}, servicehandler:{user_id: customer_user.id, subhandler: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: "TNSJ 3720", servicerequest_id: servicerequest.id}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user not signed_in with invalid params" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :create, params: {id: servicerequest.id, servicerequest: {primary_technician_id: employee_user_1.id}, servicehandler:{user_id: customer_user.id, subhandler: [employee_user_2.id], vehicle_id: vehicle.id, vehicle_number: "TN 90 SJ 3793920", servicerequest_id: servicerequest.id}}
                    expect(response).to  have_http_status(302)
                end
            end
        end
    end 

    describe "get/service_handler #edit" do

        context "accessing edit" do

            # context "when user not signed_in" do
            #     let!(:service_handler){create(:service_handler, employee_id: "90", vehicle_id: vehicle.id, user_id: "90", servicerequest_id: servicerequest.id)}
            #     it "redirects to login page" do
            #         get :edit,  params: {id: service_handler.id}
            #         expect(response).to redirect_to new_user_login_session_path
            #     end
            # end

            # context "when user signed_in as admin" do
            #     it "redirects to admin page" do
            #         sign_in admin_user
            #         get :edit, params: {id: servicerequest.id}
            #         expect(response).to have_http_status(200)
            #     end
            # end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :edit, params: {id: servicerequest.id}
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :edit, params: {id: servicerequest.id}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end 

    describe "get/service_handler #index" do

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

    describe "get/service_handler #alert" do

        context "accessing alert" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :alert
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :alert
                    expect(response).to have_http_status(200)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :alert
                    expect(response).to have_http_status(200)
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :alert
                    expect(response).to have_http_status(200)
                end
            end
        end
    end  

    describe "get/service_handler #alert" do

        context "accessing alert" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :done
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :done
                    expect(response).to have_http_status(200)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :done
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :done
                    expect(response).to have_http_status(302)
                end
            end
        end
    end  

    describe "get/service_handler #existing" do

        context "accessing existing" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :existing
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :existing
                    expect(response).to have_http_status(200)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :existing
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :existing
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end  

    describe "get/service_handler #check" do

        context "accessing check" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :check, params: {id: servicerequest.id}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :check, params: {id: servicerequest.id}
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :check, params: {id: servicerequest.id}
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :check, params: { id: servicerequest.id}
                    expect(response).to have_http_status(302)
                end
            end
        end
    end  
end