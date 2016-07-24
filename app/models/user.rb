class User < ActiveRecord::Base
    has_secure_password

    has_many :events
    has_many :ticket_types
    has_many :venues
    has_many :orders, dependent: :destroy
        
    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }

    def self.from_omniauth(auth)
        # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
        # and figure out how to get email for this user.
        # Note that Facebook sometimes does not return email,
        # in that case you can use facebook-id@facebook.com as a workaround
        email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
        
        user = where(email: email).first_or_initialize
        #
        # Set other properties on user here.
        name = auth[:info][:name]
        # You may want to call user.save! to figure out why user can't save
        #
        # Finally, return user
        user.save! && user
    end
end
