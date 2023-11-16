require 'rails_helper'

RSpec.describe 'Login Page', type: :feature do
  it 'displays the login form' do
    visit new_user_session_path
    expect(page).to have_content('Log in')
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'is valid with valid attributes' do
    user = User.new(
      name: 'John Doe',
      email: 'john@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(
      email: 'john@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    expect(user).to_not be_valid
  end
end
