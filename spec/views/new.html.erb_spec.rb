require 'rails_helper'

RSpec.describe 'recipes/new', type: :view do
  let(:recipe) { FactoryBot.build(:recipe) }

  before do
    assign(:recipe, recipe)
    render
  end

  it 'displays the new recipe form' do
    expect(rendered).to have_selector('form[action="/recipes"]')
    expect(rendered).to have_field('Name')
    expect(rendered).to have_field('Description')
  end

  it 'displays a back link to the recipes index' do
    expect(rendered).to have_link('Back', href: recipes_path)
  end
end
