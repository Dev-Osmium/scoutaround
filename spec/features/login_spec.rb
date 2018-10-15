require 'rails_helper'

RSpec.feature "Login", type: :feature do
  before do
    setup
  end

  it 'logs in' do
    logout(:user)

    visit new_user_session_path
    fill_in 'user_email',    with: @user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on I18n.t('auth.sign_in')

    expect(page).to have_current_path(unit_path(@unit))
  end
end
