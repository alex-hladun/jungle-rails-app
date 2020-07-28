require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'Should save with presence of name/category/price/quantity' do
      cat1 = Category.find_or_create_by! name: 'Test'
      product1 = cat1.products.create!({
        name: 'Test Product', 
        description: 'This is a test product',
        quantity: 20,
        price: 30.01
      })
      expect(product1.name).to be_present
      expect(product1.category).to be_present
      expect(product1.price).to be_present
      expect(product1.quantity).to be_present
    end

    it 'should not save when name missing' do
      cat1 = Category.find_or_create_by! name: 'Test'
      product1 = cat1.products.create({ 
        description: 'This is a test product',
        quantity: 20,
        price: 30.01
      })
      expect(product1.errors.full_messages).to include ("Name can't be blank")
      expect{ product1.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not save when Category missing' do
      product2 = Product.create({ 
        description: 'This is a test product',
        name: 'test name',
        quantity: 20,
        price: 30.01
      })
      expect(product2.errors.full_messages).to include ("Category can't be blank")
      expect{ product2.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not save when Price missing' do
      cat1 = Category.find_or_create_by! name: 'Test'
      product1 = cat1.products.create({ 
        description: 'This is a test product',
        quantity: 20,
        name: 30.01
      })
      expect(product1.errors.full_messages).to include ("Price can't be blank")
      expect{ product1.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not save when Quantity missing' do
      cat1 = Category.find_or_create_by! name: 'Test'
      product1 = cat1.products.create({ 
        description: 'This is a test product',
        name: 'Test Name',
        price: 30.01
      })

      expect(product1.errors.full_messages).to include ("Quantity can't be blank")
      expect{ product1.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

  end

end
