class ServiceHandler < ApplicationRecord
  has_and_belongs_to_many :user_logins, foreign_key: 'user_id', join_table: :handlers_logins
  belongs_to :servicerequest, foreign_key: 'servicerequest_id'
  belongs_to :employee, class_name: 'UserLogin', foreign_key: 'employee_id'
  has_many :vehicles, through: :servicerequest, foreign_key: 'vehicle_id'

  validates :employee_id, :presence => true
  validates :vehicle_number, presence: true, format: { with: /\A[A-Z]{2}\s\d{2}\s[A-Z]{2}\s\d{4}\z/, message: "should have the format XX 99 XX 9999" }
end
