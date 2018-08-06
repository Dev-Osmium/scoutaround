require 'rails_helper'

RSpec.feature "Event submissions features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
  end

  it 'uploads a submission' do
    # puts new_event_requirement_event_submission_path(@requirement, registration: @registration.id)
    visit new_unit_event_requirement_event_submission_path(@unit, @requirement, registration: @registration.id)
    select @user.full_name,          from: 'event_submission_event_registration_id'
    select @requirement.description, from: 'event_submission_event_requirement_id'
    attach_file 'event_submission_attachment', File.expand_path('../support/test_attachment.pdf', __dir__)
    click_on I18n.t('submissions.upload')
    expect(page).to have_current_path(unit_event_event_registration_path(@unit, @event))
  end

  it 'visits the event submission page' do
    visit new_unit_event_requirement_event_submission_path(@unit, @requirement)
    expect(page).to have_current_path(new_unit_event_event_submission_path(@unit, @event))
  end
end
