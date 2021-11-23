require 'rails_helper'

RSpec.describe 'Groups', js: true, type: :system do
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
    it 'title' do
      visit new_user_session_path
      fill_in 'Email', with: 'kevin@gmail.com'
      fill_in 'Password', with: '234234'
      click_button 'Log In'
      expect(page).to have_content('CATEGORIES')
    end

    it 'links' do
      visit new_user_session_path
      fill_in 'Email', with: 'kevin@gmail.com'
      fill_in 'Password', with: '234234'
      click_button 'Log In'
      expect(page).to have_link('Logout')
      expect(page).to have_link('Add')
    end
  end

  describe 'when I click the Add category button' do
    it 'I get a page with a form to add a category' do
      visit new_user_session_path
      fill_in 'Email', with: 'kevin@gmail.com'
      fill_in 'Password', with: '234234'
      click_button 'Log In'
      click_button 'Add category'
      expect(page).to have_content('ADD CATEGORY')
      expect(page).to have_selector("input[type=submit][value='Save']")
      expect(page).to have_field('Name')
      expect(page).to have_field('Icon')
    end
  end

  describe 'when I click the Save button in an add category form' do
    it 'I get the categories page with the added category' do
      visit new_user_session_path
      fill_in 'Email', with: 'kevin@gmail.com'
      fill_in 'Password', with: '234234'
      click_button 'Log In'
      click_button 'Add category'
      fill_in 'Name', with: 'Electronics'
      fill_in 'Icon', with: 'https://www.svgrepo.com/show/354760/electronics-14.svg'
      click_button 'Save'
      expect(page).to have_content('Electronics')
    end
  end
end
