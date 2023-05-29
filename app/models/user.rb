class User < ApplicationRecord
    has_many :vehicles
    has_many :servicerequests, through: :vehicles
    has_and_belongs_to_many :service_handlers
    has_many :reviews, as: :reviewable
    has_many :payments
    has_many :service_requests_as_primary_technician, class_name: 'Servicerequest', foreign_key: 'primary_technician_id'
    has_many :service_requests_as_employee, class_name: 'ServiceHandler', foreign_key: 'employee_id'
    has_secure_password
  end