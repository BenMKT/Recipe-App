require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject(:recipe) { build(:recipe) }

  context 'with valid attributes' do
    it 'is valid' do
      expect(recipe).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'is not valid without a name' do
      recipe.name = nil
      expect(recipe).not_to be_valid
    end

    it 'is not valid without a description' do
      recipe.description = nil
      expect(recipe).not_to be_valid
    end
  end

  context 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many recipe_foods' do
      association = described_class.reflect_on_association(:recipe_foods)
      expect(association.macro).to eq :has_many
    end

    it 'has many foods through recipe_foods' do
      association = described_class.reflect_on_association(:foods)
      expect(association.macro).to eq :has_many
    end
  end
end
