require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
    end

    user1 = User.create({
        first_name: "Jay",
        last_name: "Kwerry",
        email: "jaykwerry5@gmail.com",
        password: "password",
        password_confirmation: "password"
      })

  end

  scenario "They go to login page and login" do
    # ACT
    visit root_path

    expect(page).to have_content('My Cart (0)')

    page.find('a', :text => /\ALogin\z/).click
    
    # VERIFY
    expect(page).to have_content('Email:')
    page.find('input#email').set 'jaykwerry5@gmail.com'
    page.find('input#password').set 'password'
    click_button 'Submit'
    
    expect(page).to have_content('Logout')

    save_screenshot
  end
end