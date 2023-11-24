require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new, params: { recipe_id: recipe.id }
      expect(response).to be_successful
    end
  end
end
