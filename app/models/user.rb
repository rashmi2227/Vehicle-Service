class User < ApplicationRecord
    has_many :vehicles, dependent: :destroy
    has_many :servicerequests, through: :vehicles, dependent: :destroy
    has_and_belongs_to_many :service_handlers, dependent: :destroy
    has_many :reviews, as: :reviewable, dependent: :destroy
    has_many :payments, dependent: :destroy
    has_many :service_requests_as_primary_technician, class_name: 'Servicerequest', foreign_key: 'primary_technician_id', dependent: :destroy
    has_many :service_requests_as_employee, class_name: 'ServiceHandler', foreign_key: 'employee_id', dependent: :destroy
    has_secure_password
  end