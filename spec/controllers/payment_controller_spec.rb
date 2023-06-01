require 'rails_helper'

RSpec.describe  PaymentsController do

    let!(:customer_user) {create(:user_login ,  role: "customer")}
    let!(:employee_user) {create(:user_login ,  role: "employee")}
    let!(:admin_user) {create(:user_login ,  role: "admin")}
    let!(:vehicle) {create(:vehicle, user_id: customer_user.id)}
    # let!(:primary_technician) {create(:primary_technician, primary_technician_id: employee_user.id)}
    let!(:servicerequest) {create(:servicerequest, user_id: customer_user.id, vehicle_id: vehicle.id, primary_technician_id: employee_user.id)}
    let!(:payment) {create(:payment, servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, user_id: customer_user.id, amount: "9855", payment_status: "paid")}

    describe "get/payment #form" do

        context "accessing form" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :form
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :form
                    expect(response).to have_http_status(200)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :form
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :form
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end 

    describe "get/payment #check" do

        context "accessing check" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :check, params: { id: servicerequest.id}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :check, params: { id: servicerequest.id, payment: { servicerequest_id: servicerequest.id } }
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :check, params: {id: servicerequest.id}
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :check, params: { id: servicerequest.id}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end 

    describe "get/payment #invalidservice" do

        context "accessing invalidservice" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :invalidservice
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :invalidservice
                    expect(response).to have_http_status(200)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :invalidservice
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :invalidservice
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end 

    describe "get/payment #checkamount" do

        context "accessing checkamount" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :checkamount, params: {id: payment.id, payment_status: "unpaid"}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :checkamount, params: {id: payment.id, payment_status: "unpaid"}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as admin with valid params" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :checkamount, params: {id: payment.id, payment_status: "paid"}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as admin with valid params" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :checkamount, params: {id: payment.id, payment_status: "unpaid"}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as admin with invalid params" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :checkamount, params: {id: payment.id, payment_status: "have to be payed"}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as admin with invalid params" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :checkamount, params: {id: payment.id, payment_status: nil}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :checkamount, params: {id: payment.id, payment_status: nil}
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :checkamount, params: {id: payment.id, payment_status: "unpaid"}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end 

    describe "get/payment #checkstatus" do

        context "accessing checkstatus" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :checkstatus, params: {id: payment.id}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :checkstatus, params: {id: payment.id}
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :checkstatus, params: {id: payment.id}
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :checkstatus, params: {id: payment.id}
                    expect(response).to have_http_status(302)
                end
            end
        end
    end 

    describe "get/payment #amount" do

        context "accessing amount" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :amount, params: {id: servicerequest.id}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :amount, params: {id: servicerequest.id}
                    expect(response).to have_http_status(200)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :amount, params: {id: servicerequest.id}
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :amount, params: {id: servicerequest.id}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end 

    describe "get/payment #edit" do

        context "accessing edit" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :edit, params: {id: payment.id}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :edit, params: {id: payment.id}
                    expect(response).to have_http_status(200)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :edit, params: {id: payment.id}
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :edit, params: {id: payment.id}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end 

    describe "get/payment #updateamount" do

        context "accessing updateamount" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :updateamount, params: {id: payment.id, payment:{servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, amount: "9635", payment_status: "paid"}}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :updateamount, params: {id: payment.id, payment:{servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, amount: "9635", payment_status: "paid"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :updateamount, params: {id: payment.id, payment:{servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, amount: "9635", payment_status: "paid"}}
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :updateamount, params: {id: payment.id, payment:{servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, amount: "9635", payment_status: "paid"}}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end 

    describe "get/payment #index" do

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
                    expect(response).to redirect_to root_path
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

    describe "get/payment #show" do

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
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :show
                    expect(response).to have_http_status(200)
                end
            end
        end
    end 

    describe "get/payment #paymentdone" do

        context "accessing paymentdone" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    get :paymentdone
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    get :paymentdone
                    expect(response).to have_http_status(200)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    get :paymentdone
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    get :paymentdone
                    expect(response).to have_http_status(302)
                end
            end
        end
    end 

    describe "get/payment #destroy" do

        context "accessing destroy" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    delete :destroy, params:{ id: payment.id}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    delete :destroy, params:{ id: payment.id}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    delete :destroy, params:{ id: payment.id}
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    delete :destroy, params:{ id: payment.id}
                    expect(response).to redirect_to vehicles_welcome_path
                end
            end
        end
    end 

    describe "get/payment #update" do

        context "accessing update" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    patch :update, params:{ id: payment.id}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    patch :update, params:{ id: payment.id}
                    expect(response).to redirect_to admin_welcome_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    patch :update, params:{ id: payment.id}
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    patch :update, params:{ id: payment.id}
                    expect(response).to have_http_status(302)
                end
            end
        end
    end 

    describe "get/payment #create" do

        context "accessing create" do

            context "when user not signed_in" do
                it "redirects to login page" do
                    post :create, params:{ id: servicerequest.id, payment:{servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, user_id: customer_user.id, amount: "9855", payment_status: "paid"}}
                    expect(response).to redirect_to new_user_login_session_path
                end
            end

            context "when user signed_in as admin" do
                it "redirects to admin page" do
                    sign_in admin_user
                    post :create, params:{ id: servicerequest.id, payment:{servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, user_id: customer_user.id, amount: "9855", payment_status: "paid"}}
                    expect(response).to redirect_to payments_show_path
                end
            end

            context "when user signed_in as employee" do
                it "redirects to employee page" do
                    sign_in employee_user
                    post :create, params:{ id: servicerequest.id, payment:{servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, user_id: customer_user.id, amount: "9855", payment_status: "paid"}}
                    expect(response).to redirect_to root_path
                end
            end

            context "when user signed_in as customer" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create, params:{ id: servicerequest.id, payment:{servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, user_id: customer_user.id, amount: "9855", payment_status: "paid"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as customer with valid params" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create, params:{ id: servicerequest.id, payment:{servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, user_id: customer_user.id, amount: "9855", payment_status: "paid"}}
                    expect(response).to have_http_status(302)
                end
            end

            context "when user signed_in as customer with valid params" do
                it "redirects to customer page" do
                    sign_in customer_user
                    post :create, params:{ id: servicerequest.id, payment:{servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, user_id: customer_user.id, amount: "9", payment_status: "unpaid"}}
                    expect(response).to have_http_status(302)
                end
            end
        end
    end 
end
