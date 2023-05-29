class Review < ApplicationRecord
    belongs_to :user_login, foreign_key: 'user_logins_id'
    belongs_to :reviewable, polymorphic: true

    validates :comment, :reviewable_id, :reviewable_type ,:presence => true
    validates :comment, length: { maximum: 255, message: "should be at most 255 characters long" },format: { with: /\A[A-Za-z\s]+\z/, message: "should only contain letters and spaces" }


    scope :review_for_servicing,-> { where(reviewable_type: 'Servicerequest') }
    scope :review_for_users, -> { where(reviewable_type: 'UserLogin') }
end