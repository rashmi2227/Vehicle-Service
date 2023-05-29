class Servicerequest < ApplicationRecord
  belongs_to :user_login, foreign_key: 'user_id'
  belongs_to :vehicle, foreign_key: 'vehicle_id'
  has_many :service_handlers
  has_one :payment
  has_many :reviews, as: :reviewable
  belongs_to :primary_technician, class_name: 'UserLogin', foreign_key: 'primary_technician_id'

  validates :status, :start_date, :end_date, :presence => true 
  validates_format_of :start_date, :end_date, with: /\A\d{4}-\d{2}-\d{2}\z/, message: "is not in the correct date format (YYYY-MM-DD)"
  validates :status, inclusion: { in: %w(pending done), message: "can only be 'pending' or 'done'" }

  before_validation :case_convert
  def case_convert
    if status
      self.status.downcase 
    end
  end
  
  scope :pending_service, -> { where(status: 'pending') }
  scope :servicing_completed, -> { where(status: 'done') }

end
