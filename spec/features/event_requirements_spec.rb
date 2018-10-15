require 'rails_helper'

RSpec.feature "Event requirements features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
    visit unit_event_event_registrations_path(@unit, @event)
  end

  it 'visits the event requirements page' do
    visit unit_event_event_requirements_path(@unit, @event)
    expect(page).to have_current_path(unit_event_event_requirements_path(@unit, @event))
  end

  it 'shows an event' do
    visit unit_event_path(@unit, @event)
  end

  it 'adds a new event requirement' do
    visit unit_event_event_requirements_path(@unit, @event)
    click_on I18n.t('events.add_requirement.document')
    requirement_name = "I can't believe it's not butter"
    fill_in :event_requirement_description, with: requirement_name
    click_on 'Add Event Requirement'
    # expect(page).to have_content(requirement_name)
  end

  it 'visits the edit page' do
    requirement = @event.event_requirements.create(type: 'DocumentEventRequirement', description: 'test')
    visit edit_unit_event_requirement_path(@unit, requirement)
  end
end
