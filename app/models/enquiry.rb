class Enquiry < ActiveRecord::Base
    belongs_to :customer
    belongs_to :user
    validates :enquiry, presence: true
    validates :customer_id, presence: true
end