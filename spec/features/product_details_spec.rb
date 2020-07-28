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
  end

  scenario "They see a products detail page" do
    # ACT
    visit root_path

    # first('.product').click_on "Details"
    page.find('a.btn-default', match: :first).click

    # VERIFY
    expect(page).to have_content('Description')
    save_screenshot
  end
end