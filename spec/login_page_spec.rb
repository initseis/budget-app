require 'rails_helper'

RSpec.describe 'Login page', js: true, type: :system do
  before(:each) do
    @user_1 = User.create(name: "Kevin", email: "kevin@gmail.com", password: "234234")
    @group_1 = Group.create(name: "clothes", icon: "https://www.svgrepo.com/show/275006/shirt-clothes.svg", author_id: @user_1.id)
    @group_2 = Group.create(name: "foods", icon: "https://www.svgrepo.com/show/366737/food.svg", author_id: @user_1.id)
    @contract_1 = Contract.create(name: "Rockys", amount: 60.5, author_id: @user_1.id)
    @contract_2 = Contract.create(name: "Starbucks", amount: 20.3, author_id: @user_1.id)
    @contract_3 = Contract.create(name: "Kadosh", amount: 25, author_id: @user_1.id)
    @group_contract_1 = GroupContract.create(contract_id: @contract_1.id, group_id: @group_2.id)
    @group_contract_2 = GroupContract.create(contract_id: @contract_2.id, group_id: @group_2.id)
    @group_contract_3 = GroupContract.create(contract_id: @contract_3.id, group_id: @group_1.id)
    @group_contract_4 = GroupContract.create(contract_id: @contract_3.id, group_id: @group_2.id)
  end

  describe 'contains' do
    it 'username and password inputs, and Log in button' do
      visit new_user_session_path
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_selector("input[type=submit][value='Log In']")
    end
  end

  describe 'when I click the submit button' do
    it 'after filling in the username and the password with incorrect data, I get a detailed error' do
      visit new_user_session_path
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: '123456'
      click_button 'Log In'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'after filling in the username and the password with correct data, I am redirected to the root page' do
      visit new_user_session_path
      fill_in 'Email', with: 'kevin@gmail.com'
      fill_in 'Password', with: '234234'
      click_button 'Log In'
      expect(page).to have_content('CATEGORIES')
    end

    it 'should show me the logout button' do
      visit new_user_session_path
      fill_in 'Email', with: 'kevin@gmail.com'
      fill_in 'Password', with: '234234'
      click_button 'Log In'
      expect(page).to have_link('Logout')
    end
  end
end
