class UserLogin < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable, 
           :confirmable

    validates :email, format: URI::MailTo::EMAIL_REGEXP
    def self.authenticate(email,password)
        user = UserLogin.find_for_authentication(email: email)
        user&.valid_password?(password) ? user : nil
    end

    before_validation :normalize_email
    # after_validation :process_phone_number_format
    # before_save :encrypt_password
    # after_save :send_registration_email
    before_create :set_default_role
    
    validates :user_name , :role, :phone_no, :presence => true 
    validates :role, inclusion: { in: %w(admin customer employee), message: "is not a valid role" }
    validates :phone_no , :format => { :with => /\A\d+\z/ }, :length => { :minimum => 10 , :maximum => 10}
    validates :user_name, uniqueness: true,  format: { with: /\A(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^a-zA-Z0-9])\S+\z/, message: "should have at least one uppercase letter, one lowercase letter, one digit, and one special character" }
    validates :user_name, :length => { :minimum => 6 , :maximum => 20 }

    enum role: {admin: 'admin', employee: 'employee', customer: 'customer'}
    
    has_many :vehicles
    has_many :servicerequests, through: :vehicles
    has_and_belongs_to_many :service_handlers, join_table: :handlers_logins
    has_many :reviews, as: :reviewable
    has_many :payments
    has_many :service_requests_as_primary_technician, class_name: 'Servicerequest', foreign_key: 'primary_technician_id'
    has_many :service_requests_as_employee, class_name: 'ServiceHandler', foreign_key: 'employee_id'

    scope :user_as_employee, -> { where(role: 'employee') }
    scope :user_as_admin, -> { where(role: 'admin') }
    scope :user_as_customer, -> { where(role: 'customer') }
    scope :with_matching_technician, -> {joins(:servicerequests).where('servicerequests.primary_technician_id = user_logins.id') }

    private
    def normalize_email
        self.email = email.strip.downcase if email.present?
      end
    
      # def process_phone_number_format
      #   return if phone_no.blank?
      #   self.phone_no = phone_no.gsub(/\D/, '')
      #   errors.add(:phone_no, 'should be 10 digits') unless phone_no.length == 10
      # end
    
      # def encrypt_password
      #   self.password = BCrypt::Password.create(password) if password.present?
      # end
    
    #   def send_registration_email
    #     # Send registration email logic
    #   end
    
      def set_default_role
        self.role ||= 'customer'
      end
end