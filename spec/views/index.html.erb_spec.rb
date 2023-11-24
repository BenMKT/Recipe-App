require 'rails_helper'

RSpec.describe 'public_recipes/index', type: :view do
  let(:public_recipes) { FactoryBot.create_list(:recipe, 3, public: true, user: FactoryBot.create(:user)) }

  before do
    assign(:public_recipes, public_recipes)
    render
  end

  it 'displays the list of public recipes' do
    public_recipes.each do |recipe|
      expect(rendered).to have_link(recipe.name, href: recipe_path(recipe))
      expect(rendered).to have_text("by: #{recipe.user.name}")
    end
  end
end
