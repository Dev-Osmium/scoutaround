require 'rails_helper'

RSpec.feature "Home page", :type => :feature do
  before do
    @user = FactoryBot.create(:user)
    @unit = FactoryBot.create(:troop)
    Membership.create(user: @user, unit: @unit)
  end

  it 'redirects to unit event page when user belongs to exactly one unit' do
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on I18n.t('auth.sign_in')
    expect(page).to have_current_path(unit_path(unit_id: @unit.id))
  end

  # it 'displays the home page when user belongs to multiple units' do
  #   second_unit = FactoryBot.create(:troop)
  #   Membership.create(user: @user, unit: second_unit)

  #   visit new_user_session_path
  #   fill_in 'user_email', with: @user.email
  #   fill_in 'user_password', with: 'goscoutaround'
  #   click_on I18n.t('auth.sign_in')
  #   expect(page).to have_current_path(unit_events_path(unit: @unit))
  # end
end
