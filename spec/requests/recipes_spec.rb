require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryBot.create(:user) }

  describe 'GET #index' do
    context 'when a user is authenticated' do
      before do
        sign_in user
        get :index
      end
    end

    context 'when a user is not authenticated' do
      before do
        get :index
      end

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
