include Warden::Test::Helpers

module FeatureSpecHelper
  def setup
    @user         = FactoryBot.create(:adult)
    @unit         = FactoryBot.create(:troop)
    @event        = FactoryBot.create(:event, unit: @unit)
    @requirement  = @event.event_requirements.create(description: 'required document', type: 'DocumentEventRequirement')
    @registration = @event.event_registrations.create(user: @user)
    @membership   = Membership.create(user: @user, unit: @unit, role: :admin)
  end

  def sign_in
    setup
    login_as(@user, scope: :user)
    visit root_path

    # visit new_user_session_path
    # fill_in 'user_email',    with: @user.email
    # fill_in 'user_password', with: 'goscoutaround'
    # click_on I18n.t('auth.sign_in')
  end
end
