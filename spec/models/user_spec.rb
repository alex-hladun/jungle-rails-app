require 'rails_helper'


RSpec.describe User, type: :model do
  describe 'Validations' do
 
    it 'Should create a user when the full credentials are supplied and the passwords match' do
      user1 = User.create({
        first_name: "Jay",
        last_name: "Kwerry",
        email: "jaykwerry5@gmail.com",
        password: "password",
        password_confirmation: "password"
      })

      expect(user1).to be_valid
    end

    it 'Should NOT create a user when the passwords don\'t match' do
      user1 = User.create({
        first_name: "Jay",
        last_name: "Kwerry",
        email: "jaykwerry@gmail.com",
        password: "password",
        password_confirmation: "pas2sword"
      })

      expect(user1.errors.full_messages).to include("Password confirmation doesn't match Password")
      expect(user1).to_not be_valid
    end

    it 'Should NOT create a user when the user is already in the DB' do

      user1 = User.create({
        first_name: "Jay",
        last_name: "Kwerry",
        email: "jaykwerry@gmail.com",
        password: "password",
        password_confirmation: "password"
      })
      user2 = User.create({
        first_name: "Jay",
        last_name: "Kwerry",
        email: "jaykwerry@gmail.com",
        password: "password",
        password_confirmation: "password"
      })

      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'Should NOT create user when the last name is missing' do
      user3 = User.create({
        first_name: "Jay",
        email: "jaykwerry@gmail.com",
        password: "password",
        password_confirmation: "password"
      })

      expect(user3.errors.full_messages).to include ("Last name can't be blank")
    end

    it 'Should NOT validate when the password is less than 8 characters' do
      user2 = User.create({
        first_name: "Jay",
        last_name: "Kwerry",
        email: "jaykwerry@gmail.com",
        password: "short",
        password_confirmation: "short"
      })

      expect(user2.errors.full_messages).to include ("Users Password must be 8 or more characters")
    end
  end 

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should login successfully with proper credentials' do
      user1 = User.create({
        first_name: "Jay",
        last_name: "Kwerry",
        email: "jaykwerry5@gmail.com",
        password: "password",
        password_confirmation: "password"
      })

      expect(user1.authenticate_with_credentials('jaykwerry5@gmail.com', 'password')).to_not be_nil
    end

    it 'should NOT login  with improper credentials' do
      user1 = User.create({
        first_name: "Jay",
        last_name: "Kwerry",
        email: "jaykwerry5@gmail.com",
        password: "password",
        password_confirmation: "password"
      })

      expect(user1.authenticate_with_credentials('jaykwerry5@gmail.com', 'password2')).to be_nil
    end
    it 'should login when email is a different case' do
      user1 = User.create({
        first_name: "Jay",
        last_name: "Kwerry",
        email: "jaykwerry5@gmail.com",
        password: "password",
        password_confirmation: "password"
      })

      expect(user1.authenticate_with_credentials('JAYKWerry5@gmail.com', 'password')).to_not be_nil
    end
    it 'should login when there are leading or trailing whitespace in the email' do
      user1 = User.create({
        first_name: "Jay",
        last_name: "Kwerry",
        email: "jaykwerry5@gmail.com",
        password: "password",
        password_confirmation: "password"
      })

      expect(user1.authenticate_with_credentials('   JAYKWerry5@gmail.com   ', 'password')).to_not be_nil
    end

  
  end


end
