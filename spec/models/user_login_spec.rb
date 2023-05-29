require 'rails_helper'

RSpec.describe UserLogin, type: :model do

  describe "phone_no" do
    before(:each) do
      user_login.validate
    end

    context "when value is present" do
      let(:user_login) {build(:user_login , phone_no: "9363025833")}
      it "doesnt throw any error" do
        expect(user_login.errors).to_not include(:phone_no)
      end
    end

    context "when value is nil" do
      let(:user_login) {build(:user_login , phone_no: nil)}
      it "throws error" do
        expect(user_login.errors).to include(:phone_no)
      end
    end

    context "when value is valid" do
      let(:user_login) {build(:user_login , phone_no: "9363025833")}
      it "doesnt throw any error" do
        expect(user_login.errors).to_not include(:phone_no)
      end
    end

    context "when value is valid" do
      let(:user_login) {build(:user_login , phone_no: "9843251623")}
      it "doesnt throw any error" do
        expect(user_login.errors).to_not include(:phone_no)
      end
    end

    context "when value is invalid" do
      let(:user_login) {build(:user_login , phone_no: "84587")}
      it "throws error" do
        expect(user_login.errors).to include(:phone_no)
      end
    end

    context "when value with valid length is given" do
      let(:user_login) {build(:user_login , phone_no: "8476854538")}
      it "doesnt throw any error" do
        expect(user_login.errors).to_not include(:phone_no)
      end
    end

    context "when value with invalid length is given" do
      let(:user_login) {build(:user_login , phone_no: "87451248874512")}
      it "thrwos error" do
        expect(user_login.errors).to include(:phone_no)
      end
    end

    context "when value with invalid length is given" do
      let(:user_login) {build(:user_login , phone_no: "2")}
      it "throws error" do
        expect(user_login.errors).to include(:phone_no)
      end
    end

    context "when value is only alphabetic" do
      let(:user_login) {build(:user_login , phone_no: "sedcbhjes")}
      it "throws error" do
        expect(user_login.errors).to include(:phone_no)
      end
    end

    context "when value is numeric" do
      let(:user_login) {build(:user_login , phone_no: "2761387627")}
      it "doesnt throw any error" do
        expect(user_login.errors).to_not include(:phone_no)
      end
    end

    context "when value is alphanumeric" do
      let(:user_login) {build(:user_login , phone_no: "8785512sedb")}
      it "throws error" do
        expect(user_login.errors).to include(:phone_no)
      end
    end

    # context "when value is unique" do
    #   let(:existing_user_login) { create(:user_login, phone_no: "1234567890") }
    #   let(:user_login) { build(:user_login, phone_no: existing_user_login.phone_no) }
    
    #   it "throws error" do
    #     expect(user_login).not_to be_valid
    #     expect(user_login.errors).to include(:phone_no)
    #   end
    # end
  end

  describe "user_name" do
    before(:each) do
      user_login.validate
    end

    context "when value is present" do
      let(:user_login) {build(:user_login , user_name: "Rashmi#2")}
      it "doesnt throw any error" do
        expect(user_login.errors).to_not include(:user_name)
      end
    end
    context "when value is nil" do
      let(:user_login) {build(:user_login , user_name: nil)}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is valid" do
      let(:user_login) {build(:user_login , user_name: "Rashmi#2")}
      it "doesnt throw any error" do
        expect(user_login.errors).to_not include(:user_name)
      end
    end

    context "when value is valid" do
      let(:user_login) {build(:user_login , user_name: "Sakthi#2")}
      it "doesnt throw any error" do
        expect(user_login.errors).to_not include(:user_name)
      end
    end

    context "when value is invalid" do
      let(:user_login) {build(:user_login , user_name: "54515")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is invalid" do
      let(:user_login) {build(:user_login , user_name: "nfchbj")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is invalid" do
      let(:user_login) {build(:user_login , user_name: "Sjcbfhcf23")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is invalid" do
      let(:user_login) {build(:user_login , user_name: "sdbcfdhSf3")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is invalid" do
      let(:user_login) {build(:user_login , user_name: "hbfchre#8")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is invalid" do
      let(:user_login) {build(:user_login , user_name: "dsbcA34")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is invalid" do
      let(:user_login) {build(:user_login , user_name: "399u#d")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is invalid" do
      let(:user_login) {build(:user_login , user_name: "E328435$")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is invalid" do
      let(:user_login) {build(:user_login , user_name: "vjvbjrbvr")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is invalid" do
      let(:user_login) {build(:user_login , user_name: "451212548")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is invalid" do
      let(:user_login) {build(:user_login , user_name: "########")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value with valid length is given" do
      let(:user_login) {build(:user_login , user_name: "Rashmi#2")}
      it "doesnt throw any error" do
        expect(user_login.errors).to_not include(:user_name)
      end
    end

    context "when value with invalid length is given" do
      let(:user_login) {build(:user_login , user_name: "Ra#2")}
      it "thrwos error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value with invalid length is given" do
      let(:user_login) {build(:user_login , user_name: "RashmiKumariSinghaniya#2")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is only alphabetic" do
      let(:user_login) {build(:user_login , user_name: "sedcbhjesf")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is numeric" do
      let(:user_login) {build(:user_login , user_name: "2761387627")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value contains only capital letters" do
      let(:user_login) {build(:user_login , user_name: "ASDFGHJKQWERTYUIO")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value contains only special characters" do
      let(:user_login) {build(:user_login , user_name: "!@#$%^&*(%$#@)")}
      it "throws error" do
        expect(user_login.errors).to include(:user_name)
      end
    end

    context "when value is alphanumeric with digits and special characters" do
      let(:user_login) {build(:user_login , user_name: "Rashmi#2")}
      it "doesnt throw any error" do
        expect(user_login.errors).to_not include(:user_name)
      end
    end

    # context "when value is unique" do
    #   let!(:existing_user_login) { create(:user_login, user_name: "secefE$@t#2") }
    #   let(:user_login) { build(:user_login, user_name: "unique_user_name") }
    
    #   it "does not throw error" do
    #     expect(user_login).to be_valid
    #     expect(user_login.errors).not_to include(:user_name)
    #   end
    # end      
  end

  describe "user_login association" do

    context "has_many" do
      it "vehicles" do
          association = UserLogin.reflect_on_association(:vehicles).macro
          expect(association).to be(:has_many)
      end
    end

    context "has_many" do
      it "payments" do
          association = UserLogin.reflect_on_association(:payments).macro
          expect(association).to be(:has_many)
      end
    end

    context "assocations" do 

      it "has_many :servicerequests, through: :vehicles" do
        association = UserLogin.reflect_on_association(:servicerequests).macro
        expect(association).to be(:has_many)
        through_association = UserLogin.reflect_on_association(:servicerequests).options[:through]
        expect(through_association).to eq(:vehicles)
      end

      it "has_and_belongs_to_many :service_handlers" do
        association = UserLogin.reflect_on_association(:service_handlers).macro
        expect(association).to be(:has_and_belongs_to_many)
      end

      it "has_many :reviews, as: :reviewable" do
        association = UserLogin.reflect_on_association(:reviews).macro
        expect(association).to be(:has_many)
        as_association = UserLogin.reflect_on_association(:reviews).options[:as]
        expect(as_association).to eq(:reviewable)
      end
  
      it "has_many :payments" do
        association = UserLogin.reflect_on_association(:payments).macro
        expect(association).to be(:has_many)
      end
  
      it "has_many :service_requests_as_primary_technician, class_name: 'Servicerequest', foreign_key: 'primary_technician_id'" do
        association = UserLogin.reflect_on_association(:service_requests_as_primary_technician).macro
        expect(association).to be(:has_many)
        class_name_association = UserLogin.reflect_on_association(:service_requests_as_primary_technician).options[:class_name]
        expect(class_name_association).to eq('Servicerequest')
        foreign_key_association = UserLogin.reflect_on_association(:service_requests_as_primary_technician).foreign_key
        expect(foreign_key_association).to eq('primary_technician_id')
      end
  
      it "has_many :service_requests_as_employee, class_name: 'ServiceHandler', foreign_key: 'employee_id'" do
        association = UserLogin.reflect_on_association(:service_requests_as_employee).macro
        expect(association).to be(:has_many)
        class_name_association = UserLogin.reflect_on_association(:service_requests_as_employee).options[:class_name]
        expect(class_name_association).to eq('ServiceHandler')
        foreign_key_association = UserLogin.reflect_on_association(:service_requests_as_employee).foreign_key
        expect(foreign_key_association).to eq('employee_id')
      end

    end

  end

end