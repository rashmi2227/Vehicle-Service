require 'rails_helper'

RSpec.describe VehiclesController do

    let!(:customer_user) {create(:user_login ,  role: "customer")}
    let!(:employee_user) {create(:user_login ,  role: "employee")}
    let!(:admin_user) {create(:user_login ,  role: "admin")}
    let!(:vehicle) {create(:vehicle, user_id: customer_user.id)}

    describe "get/vehicle #welcome" do
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
                    expect(response).to redirect_to employee_welcome_path
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
                    expect(response).to have_http_status(200)
                end
            end
        end
    end

    describe "get/vehicle #new" do
        context "accessing new" do
            context "when user not signed_in" do
                it "redirects_to login page" do
                    get :new
                    expect(response).to redirect_to(new_user_login_session_path)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :new
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :new
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as customer" do
                it "redirects_to login page" do
                    sign_in customer_user
                    get :new 
                    expect(response).to have_http_status(200)
                end
            end
        end
    end

    describe "get/vehicle #show" do
        context "accessing show" do
            context "when user not signed_in" do
                it "redirects_to login page" do
                    get :show
                    expect(response).to redirect_to(new_user_login_session_path)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :show
                    expect(response).to redirect_to employee_welcome_path
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :show
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as customer" do
                it "redirects_to login page" do
                    sign_in customer_user
                    get :show
                    expect(response).to have_http_status(200)
                end
            end
        end
    end

    describe "post/vehicle #create" do
        context "creating vehicle" do
            context "when user not signed_in" do
                it "redirects_to login page" do
                post :create , params:{vehicle:{ user_id: customer_user.id, vehicle_modal: "SUV", make: "benz", vehicle_number: "TN 87 CB 2343", purchase_date:"2023-05-25", color: "blue"}}
                expect(response).to redirect_to(new_user_login_session_path)
                end
            end
    
            context "when signed_in as admin" do
                it "redirects_to login page" do
                    sign_in admin_user
                    post :create , params:{vehicle:{ user_id: customer_user.id, vehicle_modal: "SUV", make: "benz", vehicle_number: "TN 87 CB 2343", purchase_date:"2023-05-25", color: "blue"}}
                    expect(response).to redirect_to(root_path)
                end
            end

            context "when signed_in as employee" do
                it "redirects_to login page" do
                    sign_in employee_user
                    post :create , params:{vehicle:{ user_id: customer_user.id, vehicle_modal: "SUV", make: "benz", vehicle_number: "TN 87 CB 2343", purchase_date:"2023-05-25", color: "blue"}}
                    expect(response).to redirect_to(employee_welcome_path)
                end
            end
    
            context "when signed_in as customer and invalid params" do
                it "renders new page" do
                    sign_in customer_user
                    post :create , params:{vehicle:{ user_id: customer_user.id, vehicle_modal: "my car", make: "audi", vehicle_number: "TN 87 CB 2343", purchase_date:"2023-05-25", color: "blue"}}
                    expect(response).to redirect_to vehicles_create_path
                end
            end
    
            context "when signed_in as customer and invalid params" do
                it "puts a fail notice " do
                    sign_in customer_user
                    post :create , params:{vehicle:{ user_id: customer_user.id, vehicle_modal: "audi 500 gt", make: "benz", vehicle_number: "TN 87 CB 23542", purchase_date:"2023-05-25", color: "blue"}}
                    expect(response).to redirect_to vehicles_create_path
                end
            end
    
            context "when signed_in as customer and valid params" do
                it "redirects_to cart index page" do
                    sign_in customer_user
                    post :create , params:{vehicle:{ user_id: customer_user.id, vehicle_modal: "SUV", make: "benz", vehicle_number: "TN 87 CB 2343", purchase_date:"2023-05-25", color: "blue"}}
                    expect(flash[:notice]).to eq("Vehicle was successfully created.")
                end
            end
    
            context "when signed_in as customer and valid params" do
                it "puts a success notice " do
                    sign_in customer_user
                    post :create , params:{vehicle:{ user_id: customer_user.id, vehicle_modal: "SUV", make: "benz", vehicle_number: "TN 87 CB 2343", purchase_date:"2023-05-25", color: "blue"}}
                    expect(flash[:notice]).to eq("Vehicle was successfully created.")
                end
            end
        end
    end

    describe "put/cart #edit" do
        context "accessing edit page" do
            context "when user not signed_in" do
                    it "redirects_to login page" do
                    put :edit , params:{id: vehicle.id}
                    expect(response).to redirect_to(new_user_login_session_path)
                end
            end
    
            context "when signed_in as seller" do
                it "redirects_to login page" do
                    sign_in admin_user
                    put :edit , params:{id: vehicle.id}
                    expect(response).to redirect_to(root_path)
                end
            end

            context "when signed_in as seller" do
                it "redirects_to login page" do
                    sign_in employee_user
                    put :edit , params:{id: vehicle.id}
                    expect(response).to redirect_to(employee_welcome_path)
                end
            end
        
            context "when signed_in as customer" do
                it "renders edit page" do
                    sign_in customer_user
                    put :edit , params:{id: vehicle.id}
                    expect(response).to have_http_status(200)
                end
            end
        end
    end

    describe "patch/vehicle #update" do
        context "updating vehicle brand" do
            context "when user not signed_in" do
                    it "redirects_to login page" do
                    put :update , params:{id: vehicle.id}
                    expect(response).to redirect_to(new_user_login_session_path)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects_to login page" do
                    sign_in employee_user
                    patch :update , params:{id: vehicle.id}
                    expect(response).to redirect_to(employee_welcome_path)
                end
            end

            context "when signed_in as admin" do
                it "redirects_to login page" do
                    sign_in admin_user
                    put :update , params:{id: vehicle.id}
                    expect(response).to redirect_to(root_path)
                end
            end

            context "when signed_in as customer and invalid params" do
                it "renders a new page" do
                    sign_in customer_user
                    patch :update , params:{id: vehicle.id , vehicle:{vehicle_modal: "ash blue" }}
                    expect(response).to redirect_to bike_update_path
                end
            end
    
            context "when signed_in as customer and invalid params" do
                it "renders a new page" do
                    sign_in customer_user
                    patch :update , params:{id: vehicle.id , vehicle:{vehicle_modal: "ash blue"}}
                    expect(response).to redirect_to bike_update_path
                end
            end 
    
            context "when signed_in as customer and valid params" do
                it "put a success notice" do
                    sign_in customer_user
                    patch :update , params:{id: vehicle.id , vehicle:{color: "ash blue" }}
                    expect(flash[:notice]).to eq("Vehicle updated successfully.")
                end
            end
    
            context "when signed_in as customer and valid params" do
                it "puts a success notice" do
                    sign_in customer_user
                    patch :update , params:{id: vehicle.id , vehicle:{color: "ash blue"}}
                    expect(flash[:notice]).to eq("Vehicle updated successfully.")
                end
            end    
        end
    end

    describe "get/vehicle #alert" do
        context "accessing alert" do
            context "when user not signed_in" do
                it "redirects_to login page" do
                    get :alert
                    expect(response).to redirect_to(new_user_login_session_path)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :alert
                    expect(response).to have_http_status(200)
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :alert
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as customer" do
                it "redirects_to login page" do
                    sign_in customer_user
                    get :alert 
                    expect(response).to have_http_status(200)
                end
            end
        end
    end

    describe "get/vehicle #alert" do
        context "accessing alert" do
            context "when user not signed_in" do
                it "redirects_to login page" do
                    get :alert
                    expect(response).to redirect_to(new_user_login_session_path)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to login page" do
                    sign_in employee_user
                    get :alert
                    expect(response).to have_http_status(200)
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :alert
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as customer" do
                it "redirects_to login page" do
                    sign_in customer_user
                    get :alert 
                    expect(response).to have_http_status(200)
                end
            end
        end
    end

    describe "post/checkvehicle #checkvehicle" do
        context "accessing checkvehicle" do
            context "when user not signed_in" do
                it "redirects_to login page" do
                    post :checkvehicle, params: { vehicle:{vehicle_number: "TN 37 CB 2721"}}
                    expect(response).to redirect_to(new_user_login_session_path)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to details page" do
                    sign_in employee_user
                    post :checkvehicle, params: { vehicle:{vehicle_number: "TN 37 CB 2721"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when signed_in as employee and invaid params" do
                it "redirects to notfound page" do
                    sign_in employee_user
                    post :checkvehicle, params: { vehicle:{ vehicle_number: "TNU 37 CBE 2721"}}
                    expect(response).to redirect_to vehicle_view_path
                end
            end

            context "when signed_in as employee and invalid params" do
                it "redirects to notfound page" do
                    sign_in employee_user
                    post :checkvehicle, params: { vehicle:{vehicle_number: "TNE 37 CB 2721"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when signed_in as employee and valid params" do
                it "redirects to details page" do
                    sign_in employee_user
                    post :checkvehicle, params: { vehicle:{vehicle_number: "wi 37 jd 2721"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when signed_in as employee ans valid params" do
                it "redirects to details page" do
                    sign_in employee_user
                    post :checkvehicle, params: {vehicle:{ vehicle_number: "KL 37 CB 5461"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    post :checkvehicle, params: {vehicle:{ vehicle_number: "UP 37 CB 8945"}}
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as customer" do
                it "redirects_to login page" do
                    sign_in customer_user
                    post :checkvehicle, params: {vehicle:{ vehicle_number: "TN 37 CB 2721"}}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end

    describe "get/details #details" do
        context "accessing details" do
            context "when user not signed_in" do
                it "redirects_to login page" do
                    get :details, params: {id: vehicle.id}
                    expect(response).to redirect_to(new_user_login_session_path)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to details page" do
                    sign_in employee_user
                    get :details, params: {id: vehicle.id}
                    expect(response).to have_http_status(200)
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :details, params: {id: vehicle.id}
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as customer" do
                it "redirects_to login page" do
                    sign_in customer_user
                    get :details, params: {id: vehicle.id}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end
    describe "get/vehicle #details" do
        context "accessing details" do
            context "when user not signed_in" do
                it "redirects_to login page" do
                    get :notfound
                    expect(response).to redirect_to(new_user_login_session_path)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to notfound page" do
                    sign_in employee_user
                    get :notfound
                    expect(response).to have_http_status(200)
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :notfound
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as customer" do
                it "redirects_to login page" do
                    sign_in customer_user
                    get :notfound
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end

    describe "get/vehicle/service #done" do
        context "accessing details" do
            context "when user not signed_in" do
                it "redirects_to login page" do
                    get :done
                    expect(response).to redirect_to(new_user_login_session_path)
                end
            end
    
            context "when signed_in as employee" do
                it "redirects to notfound page" do
                    sign_in employee_user
                    get :done
                    expect(response).to have_http_status(200)
                end
            end

            context "when signed_in as admin" do
                it "redirects to login page" do
                    sign_in admin_user
                    get :done
                    expect(response).to redirect_to root_path
                end
            end
    
            context "when signed_in as customer" do
                it "redirects_to login page" do
                    sign_in customer_user
                    get :done
                    expect(response).to have_http_status(200)
                end
            end
        end
    end
end