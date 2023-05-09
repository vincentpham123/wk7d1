class User < ApplicationRecord
    validates :password, length: {minimum: 6, allow_nil: true}
    validates :username, presence: true, uniqueness: true 

    after_initialize :ensure_session_token
    attr_reader :password
    def password=(password)
    
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def reset_session_token! 
        self.session_token ||= SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end
    
    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64 
    end

    def self.find_by_cred(username,password)
        user =User.find_by(username:  username)
        if user
            password_object = BCrypt::Password.new(user.password_digest)
            if password_object.is_password?(password)
                return user 
            else
                return nil 
            end
        else
            return nil 
        end
    end

    

        





end
