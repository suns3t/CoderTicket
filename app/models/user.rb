class User < ActiveRecord::Base
    has_secure_password

    has_many :events
    has_many :ticket_types
    has_many :venues
    has_many :orders, dependent: :destroy
        
    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }
end
