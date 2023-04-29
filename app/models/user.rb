class User < ApplicationRecord
  has_many :vehicles
  has_many :servicerequests, through: :vehicles
  has_secure_password
end
