require 'rails_helper'

RSpec.feature "Membership features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
    first(:link, I18n.t('members.roster')).click
  end

  it 'is on the Roster page' do
    expect(page).to have_current_path(unit_memberships_path(@unit))
  end

  it 'shows a membership' do
    visit unit_membership_path(@unit, @membership)
    expect(page).to have_current_path(unit_membership_path(@unit, @membership))
  end

  it 'adds a new Youth' do
    click_on I18n.t('memberships.add.youth')
    expect(page).to have_current_path(new_unit_membership_path(@unit, type: 'youth'))
    fill_in 'membership_user_attributes_first_name', with: 'Mortimer'
    fill_in 'membership_user_attributes_last_name', with: 'Snerd'
    click_on I18n.t('memberships.add_new')
  end

  it 'displays the membership page for a guardee' do
    member = @membership.user
    guardian = FactoryBot.create(:adult)
    @unit.memberships.create(user_id: guardian.id)
    Guardianship.create(guardee_id: member.id, guardian_id: guardian.id)
    expect(member.guardians.count).to eq(1)
    visit unit_membership_path(@unit, @membership)
    expect(page).to have_current_path(unit_membership_path(@unit, @membership))
  end

  it 'displays the membership page for a guardian' do
    member = @membership.user
    guardee = FactoryBot.create(:youth)
    @unit.memberships.create(user_id: guardee.id)
    Guardianship.create(guardian_id: member.id, guardee_id: guardee.id)
    expect(member.guardees.count).to eq(1)
    visit unit_membership_path(@unit, @membership)
    expect(page).to have_current_path(unit_membership_path(@unit, @membership))
  end

  it 'displays the membership edit page' do
    visit edit_unit_membership_path(@unit, @membership)
    expect(page).to have_current_path(edit_unit_membership_path(@unit, @membership))
  end

  describe 'editing' do
    it 'has adult positions when editing an adult' do
      visit edit_unit_membership_path(@unit, @membership)
      expect(page).to have_select('membership_unit_position_id', @membership.unit.unit_positions.map(&:name))
    end
  end
end
