require 'rails_helper'

RSpec.feature 'General Shopping List', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }

  scenario 'User views the general shopping list with missing food items' do
    visit general_shopping_list_path
  end

  scenario 'User views the general shopping list with no missing food items' do
    visit general_shopping_list_path

    expect(page).not_to have_table('shopping-list-table')
  end
end
