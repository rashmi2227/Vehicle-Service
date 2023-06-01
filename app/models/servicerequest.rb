class Servicerequest < ApplicationRecord
  belongs_to :user_login, foreign_key: 'user_id'
  belongs_to :vehicle, foreign_key: 'vehicle_id'
  has_many :service_handlers
  has_one :payment
  has_many :reviews, as: :reviewable
  belongs_to :primary_technician, class_name: 'UserLogin', foreign_key: 'primary_technician_id'

  validates :status, :start_date, :end_date, presence: true
  validates_format_of :start_date, :end_date, with: /\A\d{4}-\d{2}-\d{2}\z/, message: "is not in the correct date format (YYYY-MM-DD)"
  validates :status, inclusion: { in: %w(pending done), message: "can only be 'pending' or 'done'" }

  before_validation :case_convert
  def case_convert
    self.status&.downcase
  end

  validate :start_date_greater_than_purchase_date
  validate :end_date_greater_than_start_date
  validate :check_date_difference

  def check_date_difference
    if start_date.present? && end_date.present? && (end_date - start_date).to_i > 7
      errors.add(:end_date, "should be within 7 days from the start date")
    end
  end

  def start_date_greater_than_purchase_date
    return unless start_date.present? && vehicle.present?

    if start_date < vehicle.purchase_date
      errors.add(:start_date, "must be greater than the purchase date")
    end
  end

  def end_date_greater_than_start_date
    return unless end_date.present? && start_date.present?

    if end_date < start_date
      errors.add(:end_date, "must be greater than the start date")
    end
  end

  scope :pending_service, -> { where(status: 'pending') }
  scope :servicing_completed, -> { where(status: 'done') }
end
