class User < ActiveRecord::Base

 
  has_secure_password
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :password, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :password_long_enough
  validate :passwords_must_match

  
  def authenticate_with_credentials(email, password)
    
    @user = User.find_by_email(email.downcase.strip)
    if @user
      check_user = @user.authenticate(password)
      if check_user
        return check_user
      else
        errors.add(:users, "Invalid Login Credentials")
        return nil
      end
    end
    return nil
  end

  private
  def passwords_must_match
    if self.password != self.password_confirmation
      errors.add(:users, "Passwords must match")
      return false
    end
  end


  def password_long_enough
    if self.password.size < 8
      errors.add(:users, "Password must be 8 or more characters")
      return false
    end
  end




  
end
