require 'rails_helper'

RSpec.describe 'recipes/show', type: :view do
  let(:user) { FactoryBot.build(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }

  before do
    assign(:recipe, recipe)
    allow(view).to receive(:current_user).and_return(user)
    render
  end

  it 'displays recipe details' do
    expect(rendered).to match(/#{recipe.name}/)
    expect(rendered).to match(/#{recipe.preparation_time}/)
    expect(rendered).to match(/#{recipe.cooking_time}/)
  end

  it 'displays buttons for authorized user' do
    expect(rendered).to have_link('Generate shopping list', href: general_shopping_list_path)
    expect(rendered).to have_link('Add ingredient', href: new_recipe_recipe_food_path(recipe))
  end

  it 'displays make public/private button for recipe owner' do
    expect(rendered).to have_button('Make it Private') if recipe.public?
    expect(rendered).to have_button('Make it Public') unless recipe.public?
  end
end
