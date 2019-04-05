# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    validates :email, :session_token, uniqueness: true, presence: true
    validates :password, presence: true, length: {minimum: 6}, allow_nil: true
    after_initialize :ensure_session_token

    attr_reader :password

    def self.generate_session_token
        self.session_token = SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password) #hunter12  #.new must take in arg of bcrypt string
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end
   
    def self.find_by_credentials(email_input, password_input)
        user = User.find_by(email: email_input)

        if user && user.is_password?(password_input) #why is user calling is_password?, instead of password_digest calling is_password?
            return user
        else
            return nil
        end
    end

end
