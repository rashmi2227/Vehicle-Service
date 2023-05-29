require 'rails_helper'

RSpec.describe Payment, type: :model do
    describe "payment_status" do
        before(:each) do
          payment.validate
        end
    
        context "when value is present" do
          let(:payment) {build(:payment , payment_status: "paid")}
          it "doesnt throw any error" do
            expect(payment.errors).to_not include(:payment_status)
          end
        end

        context "when value is nil" do
            let(:payment) {build(:payment , payment_status: nil)}
            it "throws error" do
              expect(payment.errors).to include(:payment_status)
            end
        end

        context "when value is valid" do
            let(:payment) {build(:payment , payment_status: "paid")}
            it "doesnt throw any error" do
              expect(payment.errors).to_not include(:payment_status)
            end
        end

        context "when value is valid" do
            let(:payment) {build(:payment , payment_status: "unpaid")}
            it "doesnt throw any error" do
              expect(payment.errors).to_not include(:payment_status)
            end
        end

        context "when value is invalid" do
            let(:payment) {build(:payment , payment_status: "Paid")}
            it "throws error" do
              expect(payment.errors).to include(:payment_status)
            end
        end

        context "when value is invalid" do
            let(:payment) {build(:payment , payment_status: "Unpaid")}
            it "throws error" do
              expect(payment.errors).to include(:payment_status)
            end
        end
    end

    describe "amount" do
        before(:each) do
          payment.validate
        end
    
        context "when value is present" do
          let(:payment) {build(:payment , amount: "5000")}
          it "doesnt throw any error" do
            expect(payment.errors).to_not include(:amount)
          end
        end

        context "when value is nil" do
            let(:payment) {build(:payment , amount: nil)}
            it "throws error" do
              expect(payment.errors).to include(:amount)
            end
        end

        context "when value is valid" do
            let(:payment) {build(:payment , amount: "2025")}
            it "doesnt throw any error" do
              expect(payment.errors).to_not include(:amount)
            end
        end

        context "when value is valid" do
            let(:payment) {build(:payment , amount: "30000")}
            it "doesnt throw any error" do
              expect(payment.errors).to_not include(:amount)
            end
        end

        context "when value is invalid" do
            let(:payment) {build(:payment , amount: "85")}
            it "throws error" do
              expect(payment.errors).to include(:amount)
            end
        end

        context "when value is valid" do
            let(:payment) {build(:payment , amount: "dfjvnf")}
            it "throws rror" do
              expect(payment.errors).to include(:amount)
            end
        end

        context "when value is valid" do
            let(:payment) {build(:payment , amount: "fvnfhd8789")}
            it "throws error" do
              expect(payment.errors).to include(:amount)
            end
        end

        context "when value is invalid" do
            let(:payment) {build(:payment , amount: "3uedwe383e#@$")}
            it "throws error" do
              expect(payment.errors).to include(:amount)
            end
        end

        context "when value with valid length is given" do
            let(:payment) {build(:payment , amount: "84788")}
            it "doesnt throw any error" do
              expect(payment.errors).to_not include(:amount)
            end
          end
      
        context "when value with invalid length is given" do
            let(:payment) {build(:payment , amount: "87")}
            it "thrwo error" do
                expect(payment.errors).to include(:amount)
            end
        end
    end

    describe "payment_associations" do 

      # context "has_one vehicle through servicerequest" do
      #   let(:vehicle) { create(:vehicle) }
      #   let(:primary_technician) {create(:user_login)}
      #   let(:servicerequest) { create(:servicerequest, vehicle: vehicle.id, primary_technician: primary_technician.id) }
      #   let(:payment) { create(:payment, servicerequest: servicerequest) }
      
      #   it "is an instance of Vehicle" do
      #     expect(payment.vehicle).to be_an_instance_of(Vehicle)
      #   end
      # end  
      
    #   it "has_one :vehicle, through: :servicerequests" do
    #     association = Payment.reflect_on_association(:servicerequests).macro
    #     expect(association).to be(:has_many)
    #     through_association = UserLogin.reflect_on_association(:servicerequests).options[:through]
    #     expect(through_association).to eq(:vehicles)
    #   end
    # end

    context "has_one vehicle through servicerequest" do
      it "has_one :vehicle through :servicerequest" do
        association = Payment.reflect_on_association(:vehicle)
        expect(association.macro).to be(:has_one)
        expect(association.options[:through]).to eq(:servicerequest)
      end
    end 
    
    context "belongs_to servicerequest" do
      let(:user) { create(:user_login) }
      let(:vehicle) { create(:vehicle, user_id: user.id) }
      let(:primary_technician) { create(:user_login) }
      let(:servicerequest) { create(:servicerequest, vehicle_id: vehicle.id, primary_technician_id: primary_technician.id, user_id: user.id) }
      let(:payment) { create(:payment, servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, user_id: user.id)}
    
      it "is an instance of ServiceRequest" do
        expect(payment.servicerequest).to be_an_instance_of(Servicerequest)
      end
    end

    context "belongs_to user" do
      let(:user) { create(:user_login) }
      let(:vehicle) { create(:vehicle, user_id: user.id) }
      let(:primary_technician) { create(:user_login) }
      let(:servicerequest) { create(:servicerequest, vehicle_id: vehicle.id, primary_technician_id: primary_technician.id, user_id: user.id) }
      let(:payment) { create(:payment, servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, user_id: user.id)}
    
      it "is an instance of User" do
        expect(payment.user_login).to be_an_instance_of(UserLogin)
      end
    end

    context "belongs_to vehicle" do
      let(:user) { create(:user_login) }
      let(:vehicle) { create(:vehicle, user_id: user.id) }
      let(:primary_technician) { create(:user_login) }
      let(:servicerequest) { create(:servicerequest, vehicle_id: vehicle.id, primary_technician_id: primary_technician.id, user_id: user.id) }
      let(:payment) { create(:payment, servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, user_id: user.id)}
    
      it "is an instance of vehicle" do
        expect(payment.vehicle).to be_an_instance_of(Vehicle)
      end
    end
    
    # context "belongs_to user_login" do
    #   let(:user_login) { create(:user_login) }
    #   let(:vehicle) { create(:vehicle, user_login: user_login) }
    
    #   it "is an instance of UserLogin" do
    #     expect(vehicle.user_login).to be_an_instance_of(UserLogin)
    #   end
    # end    

  end
end