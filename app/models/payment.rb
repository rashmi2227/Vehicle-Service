class Payment < ApplicationRecord
    belongs_to :servicerequest, foreign_key: 'servicerequest_id'
    belongs_to :user_login, foreign_key: 'user_id'
    has_one :vehicle , through: :servicerequest

    validates :payment_status, :amount, :presence => true
    validates :payment_status, inclusion: { in: %w(paid unpaid), message: "can only be 'paid' or 'unpaid'" }      
    validates :amount, format: { with: /\A\d+\z/, message: "should only contain digits" } ,length: { minimum: 3}

    scope :pending_payment_status, -> { where(payment_status: 'unpaid') }
    scope :paid_payment_status, -> { where(payment_status: 'paid') }
end