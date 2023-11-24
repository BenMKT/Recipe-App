require 'rails_helper'
require 'rspec/rails'
require 'shoulda/matchers'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:food) { Food.create(user:, measurement_unit: 'gram', price: 1.2, quantity: 1) }

  describe 'associations' do
    it 'belongs to user' do
      expect(food.user).to eq(user)
    end

    it 'has many recipe_foods' do
      expect(Food.reflect_on_association(:recipe_foods).macro).to eq(:has_many)
    end
    it 'has many recipes through recipe_foods' do
      expect(Food.reflect_on_association(:recipes).through_reflection.name).to eq(:recipe_foods)
    end
  end
  describe 'validation' do
    it 'name should be present' do
      food.name = nil
      expect(food).not_to be_valid
    end
    it 'is not valid with a negative price' do
      food.price = -1
      expect(food).not_to be_valid
    end
    it 'is not valid with a negative quantity' do
      food.quantity = -1
      expect(food).not_to be_valid
    end

    it 'price should be valid numericality' do
      food.price = 'not_an_integer'
      expect(food).not_to be_valid
    end
    it 'quantity should be valid numericality' do
      food.quantity = 'not_an_integer'
      expect(food).not_to be_valid
    end
  end
end
