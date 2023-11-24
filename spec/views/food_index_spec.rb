require 'rails_helper'

RSpec.describe 'foods/index', type: :view do
  let(:user) { FactoryBot.create(:user) }

  before do
    allow(view).to receive(:current_user).and_return(user)
    assign(:foods, []) # Assign an empty array or mock data to the @foods instance variable
    render
  end

  it 'renders the index template' do
    expect(view).to render_template(:index)
  end

  it 'displays a link to add new food' do
    expect(rendered).to have_link('Add Food', href: new_food_path)
  end

  it 'displays a message when there are no available foods' do
    expect(rendered).not_to have_table('food-table')
  end
end
