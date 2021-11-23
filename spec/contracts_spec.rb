require 'rails_helper'

RSpec.describe 'Contracts', js: true, type: :system do
  before(:each) do
    @user_1 = User.create(name: 'Kevin', email: 'kevin@gmail.com', password: '234234')
    @group_1 = Group.create(name: 'clothes', icon: 'https://www.svgrepo.com/show/275006/shirt-clothes.svg',
                            author_id: @user_1.id)
    @group_2 = Group.create(name: 'foods', icon: 'https://www.svgrepo.com/show/366737/food.svg', author_id: @user_1.id)
    @contract_1 = Contract.create(name: 'Rockys', amount: 60.5, author_id: @user_1.id)
    @contract_2 = Contract.create(name: 'Starbucks', amount: 20.3, author_id: @user_1.id)
    @contract_3 = Contract.create(name: 'Kadosh', amount: 25, author_id: @user_1.id)
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
      click_link 'Foods'
      expect(page).to have_content('CONTRACTS')
    end

    it 'links' do
      visit new_user_session_path
      fill_in 'Email', with: 'kevin@gmail.com'
      fill_in 'Password', with: '234234'
      click_button 'Log In'
      click_link 'Foods'
      expect(page).to have_link('Add')
      expect(page).to have_button('Add contract')
    end
  end

  describe 'contains' do
    it 'contracts' do
      visit new_user_session_path
      fill_in 'Email', with: 'kevin@gmail.com'
      fill_in 'Password', with: '234234'
      click_button 'Log In'
      click_link 'Foods'
      expect(page).to have_content('Kadosh')
      expect(page).to have_content('Starbucks')
    end
  end

  describe 'when I click the Add contract button' do
    it 'I get a page with a form to add a contract' do
      visit new_user_session_path
      fill_in 'Email', with: 'kevin@gmail.com'
      fill_in 'Password', with: '234234'
      click_button 'Log In'
      click_link 'Foods'
      click_button 'Add contract'
      expect(page).to have_content('ADD CONTRACT')
      expect(page).to have_selector("input[type=submit][value='Save']")
      expect(page).to have_field('Name')
      expect(page).to have_content('Categories')
      expect(page).to have_content('Clothes')
      expect(page).to have_content('Foods')
    end
  end

  describe 'when I click the Save button in an add contract form' do
    it 'I get the contracts page with the added contract' do
      visit new_user_session_path
      fill_in 'Email', with: 'kevin@gmail.com'
      fill_in 'Password', with: '234234'
      click_button 'Log In'
      click_link 'Foods'
      click_button 'Add contract'
      fill_in 'Name', with: 'Chillis'
      fill_in 'Amount', with: 100
      find(:css, "#groups_[value='2']").set(true)
      click_button 'Save'
      expect(page).to have_content('Chillis')
    end
  end
end
