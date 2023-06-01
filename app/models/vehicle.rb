class Vehicle < ApplicationRecord
  belongs_to :user_login, foreign_key: 'user_id'
  has_one :servicerequest

  validates :vehicle_modal, :make, :color, :purchase_date, presence: true
  validates :vehicle_modal, length: { in: 3..20 }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows alphabetical characters" }
  validates :vehicle_modal, inclusion: { in: ["sedan", "SUV", "hatchback", "truck", "convertible", "van", "motorcycle", "coupe", "minivan", "pickup", "bike" , "car"] }
  validates :vehicle_number, presence: true, uniqueness: true, format: { with: /\A[A-Z]{2}\s\d{2}\s[A-Z]{2}\s\d{4}\z/, message: "should have the format XX 99 XX 9999" }

  before_save :purchase_date_cannot_be_greater_than_current_date

  def purchase_date_cannot_be_greater_than_current_date
    if purchase_date.present? && purchase_date > Date.current
      errors.add(:purchase_date, "cannot be in the future")
      throw(:abort) # Stop the saving process
    end
  end

end
