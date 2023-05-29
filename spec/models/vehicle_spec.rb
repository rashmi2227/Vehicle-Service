require 'rails_helper'

RSpec.describe Vehicle, type: :model do

    describe "vehicle_modal" do
        before(:each) do
          vehicle.validate
        end

        context "when value is present" do
          let(:vehicle) {build(:vehicle , vehicle_modal: "sedan")}
          it "doesnt throw any error" do
            expect(vehicle.errors).to_not include(:vehicle_modal)
          end
        end
        context "when value is nil" do
          let(:vehicle) {build(:vehicle , vehicle_modal: nil)}
          it "throws error" do
            expect(vehicle.errors).to include(:vehicle_modal)
          end
        end
    
        context "when value is valid" do
          let(:vehicle) {build(:vehicle , vehicle_modal: "SUV")}
          it "doesnt throw any error" do
            expect(vehicle.errors).to_not include(:vehical_modal)
          end
        end
    
        context "when value is valid" do
          let(:vehicle) {build(:vehicle , vehicle_modal: "minivan")}
          it "doesnt throw any error" do
            expect(vehicle.errors).to_not include(:vehical_modal)
          end
        end

        context "when value is invalid" do
          let(:vehicle) {build(:vehicle , vehicle_modal: "tn 37 cb 6869")}
          it "throws error" do
            expect(vehicle.errors).to include(:vehicle_modal)
          end
        end

        context "when value with valid length is given" do
          let(:vehicle) {build(:vehicle , vehicle_modal: "convertible")}
          it "doesnt throw any error" do
            expect(vehicle.errors).to_not include(:vehicle_modal)
          end
        end

        context "when value with valid length is given" do
          let(:vehicle) {build(:vehicle , vehicle_modal: "bike")}
          it "doesnt throw any error" do
            expect(vehicle.errors).to_not include(:vehicle_modal)
          end
        end

        context "when value with invalid length is given" do
          let(:vehicle) {build(:vehicle , vehicle_modal: "Tata Nexon 998 cc - 1197 cc 98.69 Bhp")}
          it "throws error" do
            expect(vehicle.errors).to include(:vehicle_modal)
          end
        end

        context "when value is only alphabetic" do
          let(:vehicle) {build(:vehicle , vehicle_modal: "convertible")}
          it "doesnt throw any error" do
            expect(vehicle.errors).to_not include(:vehicle_modal)
          end
        end

        context "when value is numeric" do
          let(:vehicle) {build(:vehicle , vehicle_modal: "276138762")}
          it "throws error" do
            expect(vehicle.errors).to include(:vehicle_modal)
          end
        end

        context "when value is alphanumeric" do
          let(:vehicle) {build(:vehicle , vehicle_modal: "Tata Nexon 998 cc - 1197 cc 98.69 Bhp")}
          it "throws error" do
            expect(vehicle.errors).to include(:vehicle_modal)
          end
        end
    end

    describe "vehicle_number" do
      before(:each) do
        vehicle.validate
      end

      context "when value is present" do
        let(:vehicle) {build(:vehicle , vehicle_number: "TN 37 CB 5929")}
        it "doesnt throw any error" do
          expect(vehicle.errors).to_not include(:vehicle_number)
        end
      end
      context "when value is nil" do
        let(:vehicle) {build(:vehicle , vehicle_number: nil)}
        it "throws error" do
          expect(vehicle.errors).to include(:vehicle_number)
        end
      end
  
      context "when value is valid" do
        let(:vehicle) {build(:vehicle , vehicle_number: "TN 27 CB 5929")}
        it "doesnt throw any error" do
          expect(vehicle.errors).to_not include(:vehicle_number)
        end
      end
  
      context "when value is valid" do
        let(:vehicle) {build(:vehicle , vehicle_number: "PY 45 VB 7291")}
        it "doesnt throw any error" do
          expect(vehicle.errors).to_not include(:vehicle_number)
        end
      end

      context "when value is invalid" do
        let(:vehicle) {build(:vehicle , vehicle_number: "TN 37 cb 68569")}
        it "throws error" do
          expect(vehicle.errors).to include(:vehicle_number)
        end
      end

      context "when value is invalid" do
        let(:vehicle) {build(:vehicle , vehicle_number: "TN 37 CLB 6869")}
        it "throws error" do
          expect(vehicle.errors).to include(:vehicle_number)
        end
      end

      context "when value is invalid" do
        let(:vehicle) {build(:vehicle , vehicle_number: "TN 387 CB 6869")}
        it "throws error" do
          expect(vehicle.errors).to include(:vehicle_number)
        end
      end

      context "when value is valid" do
        let(:vehicle) {build(:vehicle , vehicle_number: "TN 37 CB 6869")}
        it "doesnt throw any error" do
          expect(vehicle.errors).to_not include(:vehicle_number)
        end
      end

      context "when value with valid length is given" do
        let(:vehicle) {build(:vehicle , vehicle_number: "TN 37 CB 6869")}
        it "doesnt throw any error" do
          expect(vehicle.errors).to_not include(:vehicle_number)
        end
      end

      context "when value with invalid length is given" do
        let(:vehicle) {build(:vehicle , vehicle_number: "TN 37 CB 688969")}
        it "throws error" do
          expect(vehicle.errors).to include(:vehicle_number)
        end
      end

      context "when value with invalid length is given" do
        let(:vehicle) {build(:vehicle , vehicle_number: "TN 3 7  CBE 6869")}
        it "throws error" do
          expect(vehicle.errors).to include(:vehicle_number)
        end
      end

      context "when alphabets are in upper case" do
        let(:vehicle) {build(:vehicle , vehicle_number: "TN 37 CB 6889")}
        it "doesnt throw any error" do
          expect(vehicle.errors).to_not include(:vehicle_number)
        end
      end
      
      context "when alphabets are in lower case" do
        let(:vehicle) {build(:vehicle , vehicle_number: "tn 37 cb 6889")}
        it "throws error" do
          expect(vehicle.errors).to include(:vehicle_number)
        end
      end

      context "when value is alphanumeric" do
        let(:vehicle) {build(:vehicle , vehicle_number: "TN 37 CB 6869")}
        it "doesnt throw any error" do
          expect(vehicle.errors).to_not include(:vehicle_number)
        end
      end

      context "when value is only alphabetic" do
        let(:vehicle) {build(:vehicle , vehicle_number: "ehdjebgsjhdce")}
        it "throws error" do
          expect(vehicle.errors).to include(:vehicle_number)
        end
      end

      context "when value is only numeric" do
        let(:vehicle) {build(:vehicle , vehicle_number: "4512487")}
        it "throws error" do
          expect(vehicle.errors).to include(:vehicle_number)
        end
      end
  end

  describe "vehicle association" do 

    context "belongs_to user_login" do
      let(:user_login) { create(:user_login) }
      let(:vehicle) { create(:vehicle, user_id: user_login.id) }    
      it "is an instance of User" do
        expect(vehicle.user_login).to be_an_instance_of(UserLogin)
      end
    end

    # context "has_one servicerequest" do
    #   let(:servicerequest) { create(:servicerequest) }
    #   let(:model) { create(:your_model, servicerequest: servicerequest) }    
    #   it "is an instance of Servicerequest" do
    #     expect(model.servicerequest).to be_an_instance_of(Servicerequest)
    #   end
    # end

    context "has_one" do
      it "servicerequests" do
        assocation = Vehicle.reflect_on_association(:servicerequest).macro
        expect(assocation).to be(:has_one)
      end
    end
  end
end