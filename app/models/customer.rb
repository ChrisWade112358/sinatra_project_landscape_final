class Customer < ActiveRecord::Base
    has_many :enquiries
    has_many :users, through: :enquiries
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates_uniqueness_of :email
    validates :address, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip, presence: true
    validates :password_digest, presence: true
    has_secure_password
end