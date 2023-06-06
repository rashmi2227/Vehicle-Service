require 'rails_helper'

RSpec.describe ServiceHandler, type: :model do
    describe "vehicle_number" do
        before(:each) do
            service_handler.validate
        end

        context "when value is present" do
            let(:service_handler) {build(:vehicle , vehicle_number: "TN 37 CB 5929")}
            it "doesnt throw any error" do
                expect(service_handler.errors).to_not include(:vehicle_number)
            end
        end

        context "when value is nil" do
            let(:service_handler) {build(:vehicle , vehicle_number: nil)}
            it "throws error" do
                expect(service_handler.errors).to include(:vehicle_number)
            end
        end

        context "when value is valid" do
            let(:service_handler) {build(:vehicle , vehicle_number: "TN 27 CB 5929")}
            it "doesnt throw any error" do
                expect(service_handler.errors).to_not include(:vehicle_number)
            end
        end

        context "when value is valid" do
            let(:service_handler) {build(:vehicle , vehicle_number: "PY 45 VB 7291")}
            it "doesnt throw any error" do
                expect(service_handler.errors).to_not include(:vehicle_number)
            end
        end

        context "when value is invalid" do
            let(:service_handler) {build(:vehicle , vehicle_number: "TN 37 cb 68569")}
            it "throws error" do
                expect(service_handler.errors).to include(:vehicle_number)
            end
        end

        context "when value is invalid" do
            let(:service_handler) {build(:vehicle , vehicle_number: "TN 37 CLB 6869")}
            it "throws error" do
                expect(service_handler.errors).to include(:vehicle_number)
            end
        end

        context "when value is invalid" do
            let(:service_handler) {build(:vehicle , vehicle_number: "TN 387 CB 6869")}
            it "throws error" do
                expect(service_handler.errors).to include(:vehicle_number)
            end
        end

        context "when value is valid" do
            let(:service_handler) {build(:vehicle , vehicle_number: "TN 37 CB 6869")}
            it "doesnt throw any error" do
                expect(service_handler.errors).to_not include(:vehicle_number)
            end
        end

        context "when value with valid length is given" do
            let(:service_handler) {build(:vehicle , vehicle_number: "TN 37 CB 6869")}
            it "doesnt throw any error" do
                expect(service_handler.errors).to_not include(:vehicle_number)
            end
        end

        context "when value with invalid length is given" do
            let(:service_handler) {build(:vehicle , vehicle_number: "TN 37 CB 688969")}
            it "throws error" do
                expect(service_handler.errors).to include(:vehicle_number)
            end
        end

        context "when value with invalid length is given" do
            let(:service_handler) {build(:vehicle , vehicle_number: "TN 3 7  CBE 6869")}
            it "throws error" do
                expect(service_handler.errors).to include(:vehicle_number)
            end
        end

        context "when alphabets are in upper case" do
            let(:service_handler) {build(:vehicle , vehicle_number: "TN 37 CB 6889")}
            it "doesnt throw any error" do
                expect(service_handler.errors).to_not include(:vehicle_number)
            end
        end
        
        context "when alphabets are in lower case" do
            let(:service_handler) {build(:vehicle , vehicle_number: "tn 37 cb 6889")}
            it "throws error" do
                expect(service_handler.errors).to_not include(:vehicle_number)
            end
        end

        context "when value is alphanumeric" do
            let(:service_handler) {build(:vehicle , vehicle_number: "TN 37 CB 6869")}
            it "doesnt throw any error" do
                expect(service_handler.errors).to_not include(:vehicle_number)
            end
        end

        context "when value is only alphabetic" do
            let(:service_handler) {build(:vehicle , vehicle_number: "ehdjebgsjhdce")}
            it "throws error" do
                expect(service_handler.errors).to include(:vehicle_number)
            end
        end

        context "when value is only numeric" do
            let(:service_handler) {build(:vehicle , vehicle_number: "4512487")}
            it "throws error" do
                expect(service_handler.errors).to include(:vehicle_number)
            end
        end
    end

    describe "service_handler assocations" do

        context "associations"  do

            it "has_and_belongs_to_many :users" do
                association = ServiceHandler.reflect_on_association(:user_logins).macro
                expect(association).to be(:has_and_belongs_to_many)
            end

            it "has_many :vehicles, through: :servicerequest" do
                association = ServiceHandler.reflect_on_association(:vehicles).macro
                expect(association).to be(:has_many)
                through_association = ServiceHandler.reflect_on_association(:vehicles).options[:through]
                expect(through_association).to eq(:servicerequest)
            end
        end 
        
        # context "belongs_to UserLogin" do
        #     let!(:user_login) { create(:user_login) }
        #     let!(:vehicle) { create(:vehicle, user_id: user_login.id) }
        #     let!(:primary_technician) { create(:user_login) }
        #     let!(:servicerequest) { create(:servicerequest, vehicle_id: vehicle.id, primary_technician_id: primary_technician.id, user_id: user_login.id) }
        #     let!(:employee) { create(:user_login)}
        #     let!(:service_handler) { create(:service_handler, servicerequest_id: servicerequest.id, vehicle_id: vehicle.id, employee_id: employee.id, user_id: user_login.id)}
          
        #     it "is an instance of Servicerequest" do
        #       expect(service_handler.user_login).to be_an_instance_of(user_login)
        #     end
        # end

        # context "belongs_to user_login" do
        #     let(:user_login) { create(:user_login) }
        #     let(:service_handler) { create(:service_handler, user_id: user_login.id) }
          
        #     it "is an instance of UserLogin" do
        #       expect(service_handler.user_login).to be_an_instance_of(UserLogin)
        #     end
        # end
          
    end
end