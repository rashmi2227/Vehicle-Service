require 'rails_helper'

RSpec.describe Servicerequest, type: :model do
    describe "status" do
        before(:each) do
          servicerequest.validate
        end
    
        context "when value is present" do
          let(:servicerequest) {build(:servicerequest , status: "pending")}
          it "doesnt throw any error" do
            expect(servicerequest.errors).to_not include(:status)
          end
        end

        context "when value is nil" do
            let(:servicerequest) {build(:servicerequest , status: nil)}
            it "throws error" do
              expect(servicerequest.errors).to include(:status)
            end
        end

        context "when value is valid" do
            let(:servicerequest) {build(:servicerequest , status: "pending")}
            it "doesnt throw any error" do
              expect(servicerequest.errors).to_not include(:status)
            end
        end

        context "when value is valid" do
            let(:servicerequest) {build(:servicerequest , status: "done")}
            it "doesnt throw any error" do
              expect(servicerequest.errors).to_not include(:status)
            end
        end

        context "when value is invalid" do
            let(:servicerequest) {build(:servicerequest , status: "Pending")}
            it "throws error" do
              expect(servicerequest.errors).to include(:status)
            end
        end

        context "when value is invalid" do
            let(:servicerequest) {build(:servicerequest , status: "Done")}
            it "throws error" do
              expect(servicerequest.errors).to include(:status)
            end
        end
    end

    describe "start_date" do
        before(:each) do
          servicerequest.validate
        end
    
        context "when value is present" do
          let(:servicerequest) {build(:servicerequest , start_date: "2020/05/25")}
          it "doesnt throw any error" do
            expect(servicerequest.errors).to_not include(:start_date)
          end
        end

        context "when value is nil" do
            let(:servicerequest) {build(:servicerequest , start_date: nil)}
            it "throws error" do
              expect(servicerequest.errors).to include(:start_date)
            end
        end

        context "when value is valid" do
            let(:servicerequest) {build(:servicerequest , start_date: "2020/05/25")}
            it "doesnt throw any error" do
              expect(servicerequest.errors).to_not include(:start_date)
            end
        end

        context "when value is valid" do
            let(:servicerequest) {build(:servicerequest , start_date: "2020/05/25")}
            it "doesnt throw any error" do
              expect(servicerequest.errors).to_not include(:start_date)
            end
        end

        context "when value is valid" do
            let(:servicerequest) {build(:servicerequest , start_date: "25/05/2020")}
            it "doesnt throw any error" do
              expect(servicerequest.errors).to_not include(:start_date)
            end
        end

        context "when value is valid" do
            let(:servicerequest) {build(:servicerequest , start_date: "5/2020/25")}
            it "throws error" do
              expect(servicerequest.errors).to include(:start_date)
            end
        end

        context "when value is valid" do
            let(:servicerequest) {build(:servicerequest , start_date: "25/2020/5")}
            it "doesnt throw any error" do
              expect(servicerequest.errors).to_not include(:start_date)
            end
        end

        context "when value is invalid" do
            let(:servicerequest) {build(:servicerequest , start_date: "2020/25/20")}
            it "throws error" do
              expect(servicerequest.errors).to include(:start_date)
            end
        end
    end

    describe "end_date" do
        before(:each) do
          servicerequest.validate
        end
    
        context "when value is present" do
          let(:servicerequest) {build(:servicerequest , end_date: "2020/05/25")}
          it "doesnt throw any error" do
            expect(servicerequest.errors).to_not include(:end_date)
          end
        end

        context "when value is nil" do
            let(:servicerequest) {build(:servicerequest , end_date: nil)}
            it "throws error" do
              expect(servicerequest.errors).to include(:end_date)
            end
        end

        context "when value is valid" do
            let(:servicerequest) {build(:servicerequest ,end_date: "2020/05/25")}
            it "doesnt throw any error" do
              expect(servicerequest.errors).to_not include(:end_date)
            end
        end

        context "when value is valid" do
            let(:servicerequest) {build(:servicerequest , end_date: "2020/05/25")}
            it "doesnt throw any error" do
              expect(servicerequest.errors).to_not include(:end_date)
            end
        end

        context "when value is valid" do
            let(:servicerequest) {build(:servicerequest , end_date: "25/05/2020")}
            it "doesnt throw any error" do
              expect(servicerequest.errors).to_not include(:end_date)
            end
        end

        context "when value is valid" do
            let(:servicerequest) {build(:servicerequest , end_date: "5/2020/25")}
            it "throws error" do
              expect(servicerequest.errors).to include(:end_date)
            end
        end

        context "when value is valid" do
            let(:servicerequest) {build(:servicerequest , end_date: "25/2020/5")}
            it "doesnt throw any error" do
              expect(servicerequest.errors).to_not include(:end_date)
            end
        end

        context "when value is invalid" do
            let(:servicerequest) {build(:servicerequest , end_date: "2020/25/20")}
            it "throws error" do
              expect(servicerequest.errors).to include(:end_date)
            end
        end
    end

    describe "servicerequest association" do

      context "associations" do
        it "belongs_to :user_login, foreign_key: 'user_id'" do
          association = Servicerequest.reflect_on_association(:user_login)
          expect(association.macro).to be(:belongs_to)
          expect(association.options[:foreign_key]).to eq('user_id')
        end
    
        it "belongs_to :vehicle, foreign_key: 'vehicle_id'" do
          association = Servicerequest.reflect_on_association(:vehicle)
          expect(association.macro).to be(:belongs_to)
          expect(association.options[:foreign_key]).to eq('vehicle_id')
        end
    
        it "has_many :service_handlers" do
          association = Servicerequest.reflect_on_association(:service_handlers)
          expect(association.macro).to be(:has_many)
        end
    
        it "has_one :payment" do
          association = Servicerequest.reflect_on_association(:payment)
          expect(association.macro).to be(:has_one)
        end
    
        it "has_many :reviews, as: :reviewable" do
          association = Servicerequest.reflect_on_association(:reviews)
          expect(association.macro).to be(:has_many)
          expect(association.options[:as]).to eq(:reviewable)
        end
    
        it "belongs_to :primary_technician, class_name: 'UserLogin', foreign_key: 'primary_technician_id'" do
          association = Servicerequest.reflect_on_association(:primary_technician)
          expect(association.macro).to be(:belongs_to)
          expect(association.options[:class_name]).to eq('UserLogin')
          expect(association.options[:foreign_key]).to eq('primary_technician_id')
        end
      end

      context "belongs_to user_login" do
        let(:user_login) { create(:user_login) }
        let(:primary_technician) { create(:user_login) }
        let(:servicerequest) { create(:servicerequest, user_id: user_login.id, primary_technician_id: primary_technician.id) }
      
        it "is an instance of UserLogin" do
          expect(servicerequest.user_login).to be_an_instance_of(UserLogin)
        end
      end
      
      context "belongs_to vehicle" do
        let(:vehicle) { create(:vehicle) }
        let(:primary_technician) { create(:user_login) }
        let(:servicerequest) { create(:servicerequest, vehicle_id: vehicle.id, primary_technician_id: primary_technician.id) }
      
        it "is an instance of Vehicle" do
          expect(servicerequest.vehicle).to be_an_instance_of(Vehicle)
        end
      end
      
      context "belongs_to primary_technician" do
        let(:primary_technician) { create(:user_login) }
        let(:servicerequest) { create(:servicerequest, primary_technician_id: primary_technician.id) }
      
        it "is an instance of UserLogin" do
          expect(servicerequest.primary_technician).to be_an_instance_of(UserLogin)
        end
      end
      
    end
end