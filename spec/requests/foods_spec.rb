require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  let(:user) { User.create(name: 'John Doe') }
  before do
    allow(controller).to receive(:authenticate_user!).and_return(nil)
    allow(controller).to receive(:current_user).and_return(user)
  end
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
