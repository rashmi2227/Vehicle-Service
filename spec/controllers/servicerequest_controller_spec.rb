require 'rails_helper'

RSpec.describe ServicerequestsController do

    let!(:customer_user) {create(:user_login ,  role: "customer")}
    let!(:employee_user) {create(:user_login ,  role: "employee")}
    let!(:admin_user) {create(:user_login ,  role: "admin")}
    let!(:vehicle) {create(:vehicle, user_id: customer_user.id)}
    # let!(:primary_technician) {create(:primary_technician, primary_technician_id: employee_user.id)}
    let!(:servicerequest) {create(:servicerequest, user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id)}

    describe "post/servicerequest #create" do

        context "accessing create" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    post :create, params: {servicerequest: {user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id, start_date:"2023/05/24", end_date: "2023-05-24", status:"pending"}}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user not signed_in" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :create, params: {servicerequest: {user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id, start_date:"2023/05/24", end_date: "2023-05-24", status:"pending"}}
                    expect(response).to redirect_to root_path
                end
            end

            context "when user not signed_in" do
                it "redirects to login page" do
                    sign_in employee_user
                    post :create, params: {servicerequest: {user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id, start_date:"2023/05/24", end_date: "2023-05-24", status:"pending"}}
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user not signed_in" do
                it "redirects to login page" do
                    sign_in customer_user
                    post :create, params: {servicerequest: {user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id, start_date:"2023/05/24", end_date: "2023-05-24", status:"pending"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user not signed_in with valid params" do
                it "redirects to login page" do
                    sign_in customer_user
                    post :create, params: {servicerequest: {user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id, start_date:"2023/05/24", end_date: "2023-05-24", status:"pending"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user not signed_in with valid params" do
                it "redirects to login page" do
                    sign_in customer_user
                    post :create, params: {servicerequest: {user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id, start_date:"2023/05/24", end_date: "2023-05-24", status:"pending"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user not signed_in with invalid params" do
                it "redirects to login page" do
                    sign_in customer_user
                    post :create, params: {servicerequest: {user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id, start_date:"2023/05/24", end_date: "20238-05-24", status:"pending"}}
                    expect(response).to redirect_to root_path
                end
            end

            context "when user not signed_in with invalid params" do
                it "redirects to login page" do
                    sign_in customer_user
                    post :create, params: {servicerequest: {user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id, start_date:"2023/05/24", end_date: "2023-05-24", status:"Not done"}}
                    expect(response).to redirect_to root_path
                end
            end
        end
    end 
    
    describe "get/servicerequest #date" do

        context "accessing date" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :date,  params: {id: servicerequest.id}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :date, params: {id: servicerequest.id}
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :date, params: {id: servicerequest.id}
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :date, params: {id: servicerequest.id}
                    expect(response).to have_http_status(200)
                end
            end
        end
    end  

    describe "get/servicerequest #showbookedservice" do

        context "accessing showbookedservice" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :showbookedservice
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :showbookedservice
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :showbookedservice
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :showbookedservice
                    expect(response).to have_http_status(200)
                end
            end
        end
    end  

    describe "get/servicerequest #show" do

        context "accessing show" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :show
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :show
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :show
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :show
                    expect(response).to have_http_status(200)
                end
            end
        end
    end

    describe "get/servicerequest #showpendingservice" do

        context "accessing showpending" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :showpendingservice
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :showpendingservice
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :showpendingservice
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :showpendingservice
                    expect(response).to have_http_status(200)
                end
            end
        end
    end  

    describe "get/servicerequest #listatus" do

        context "accessing liststatus" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :liststatus,  params: {id: servicerequest.id}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :liststatus, params: {id: servicerequest.id}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :liststatus, params: {id: servicerequest.id}
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :liststatus, params: {id: servicerequest.id}
                    expect(response).to have_http_status(200)
                end
            end
        end
    end  

    describe "patch/servicerequest #update" do

        context "accessing update" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    patch :update,  params: {id: servicerequest.id, servicerequest:{ status: "done"}}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    patch :update, params: {id: servicerequest.id,servicerequest:{ status: "done"}}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    patch :update, params: {id: servicerequest.id,servicerequest: { status: "done"}}
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    patch :update, params: {id: servicerequest.id, servicerequest:{ status: "done"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as employee with valid params" do
                it "redirects to employee page" do
                    sign_in employee_user
                    patch :update, params: {id: servicerequest.id, servicerequest:{ status: "done"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as employee with valid params" do
                it "redirects to employee page" do
                    sign_in employee_user
                    patch :update, params: {id: servicerequest.id, servicerequest:{ status: "pending"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as employee with invalid params" do
                it "redirects to employee page" do
                    sign_in employee_user
                    patch :update, params: {id: servicerequest.id, servicerequest:{ status: "Incomplete"}}
                    expect(response).to redirect_to pending_service_path
                end
            end

            context "when user signed_in as employee with invalid params" do
                it "redirects to employee page" do
                    sign_in employee_user
                    patch :update, params: {id: servicerequest.id, servicerequest:{ status: "yet to be completed"}}
                    expect(response).to redirect_to pending_service_path
                end
            end
        end
    end 
    
    describe "get/servicerequest #index" do

        context "accessing index" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :index
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :index
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :index
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :index
                    expect(response).to have_http_status(200)
                end
            end
        end
    end 

    describe "get/servicerequest #checkserviceexisting" do

        context "accessing checkserviceexisting" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :checkserviceexisting,  params: {id: vehicle.id}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :checkserviceexisting, params: {id: vehicle.id}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :checkserviceexisting, params: {id: vehicle.id}
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :checkserviceexisting, params: {id: vehicle.id}
                    expect(response).to redirect_to employee_welcome_path
                end
            end
        end
    end 
    
    describe "get/servicerequest #alert" do

        context "accessing alert" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :alert
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :alert
                    expect(response).to have_http_status(200)
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
        end
    end 

    describe "get/servicerequest #done" do

        context "accessing done" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :done
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :done
                    expect(response).to have_http_status(200)
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
                    expect(response).to have_http_status(200)
                end
            end
        end
    end 
end