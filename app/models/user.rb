class User < ActiveRecord::Base
    has_many :enquiries
    has_many :customers, through: :enquiries
    validates :name, presence: true
    validates :email, presence: true
    validates_uniqueness_of :email
    validates :password_digest, presence: true
    has_secure_password
    
end