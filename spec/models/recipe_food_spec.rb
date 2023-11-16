require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:recipe) { Recipe.create(user:, preparation_time: 1, cooking_time: 1, description: 'blabla', public: true) }
  let(:food) { Food.create(user:, measurement_unit: 'gram', price: 1.2, quantity: 1) }
  let!(:recipe_food) { RecipeFood.new(food:, recipe:, quantity: 1) }

  describe 'associations' do
    it 'belongs to recipe' do
      expect(recipe_food.food).to eq(food)
    end

    it 'belongs to food' do
      expect(recipe_food.recipe).to eq(recipe)
    end
  end
  describe 'validation' do
    it 'is not valid with a negative quantity' do
      recipe_food.quantity = -1
      expect(recipe_food).not_to be_valid
    end
    it 'quantity should be valid numericality' do
      recipe_food.quantity = 'not_an_integer'
      expect(food).not_to be_valid
    end
  end
end
