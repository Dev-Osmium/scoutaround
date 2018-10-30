require 'rails_helper'

RSpec.feature "Advancement features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
    @scout = Rank.where(ordinal: 0, name: 'Scout', program_code: 'bsa').first_or_create
    @tenderfoot = Rank.where(ordinal: 1, name: 'Tenderfoot', program_code: 'bsa').first_or_create
  end

  it 'works' do
    visit unit_membership_achievements_path(@unit, @membership)
    expect(page).to have_current_path(unit_membership_achievements_path(@unit, @membership))
  end

  describe 'unit achievements' do
    before do
      @timmy = FactoryBot.create(:youth, first_name: 'Timothy', nickname: 'Timmy')
      @tommy = FactoryBot.create(:youth, first_name: 'Thomas', nickname: 'Tommy')
      @jimmy = FactoryBot.create(:youth, first_name: 'James', nickname: 'Jimmy')

      @unit.memberships.create(user: @timmy)
      @unit.memberships.create(user: @tommy)
      @unit.memberships.create(user: @jimmy, active: false)

      @timmy.achievements.create(achievable: @tenderfoot, earned_at: 2.weeks.ago, awarded_at: 2.days.ago)
      @tommy.achievements.create(achievable: @scout, earned_at: 2.weeks.ago, awarded_at: nil) # earned, but unawarded
      @jimmy.achievements.create(achievable: @scout, earned_at: 2.weeks.ago, awarded_at: nil) # earned, unawarded, inactive member
    end

    it 'unit advancement page works when a youth doesn\'t have a rank' do
      rankless_youth = FactoryBot.create(:youth, rank: nil)
      Membership.create(user: rankless_youth, unit: @unit)
      visit unit_achievements_path(@unit)
      expect(page).to have_current_path(unit_achievements_path(@unit))
    end

    it 'displays the shopping list page' do
      visit unit_achievements_path(@unit, view: 'shopping_list')
    end

    describe 'pending page' do
      before do
        visit unit_achievements_path(@unit, view: 'pending')
      end

      # Tommy's Scout rank  hasn't yet been awarded
      it 'includes unawarded member' do
        save_and_open_page
        expect(page).to have_content(@tommy.preferred_name)
      end

      # Timmy's Tenderfoot has been awarded and shouldn't appear on the shopping list
      it 'doesn\'t include unawarded member' do
        expect(page).not_to have_content(@timmy.preferred_name)
      end

      it 'doesn\'t include inactive member' do
        expect(page).not_to have_content(@jimmy.preferred_name)
      end
    end
  end

  describe 'user achievements' do
    before do
      @merit_badge = MeritBadge.create(name: 'Snorking')
      @achievement = Achievement.create!(
        user_id: @user.id,
        achievable_id: @merit_badge.id
      )
    end

    it 'visits an achievement without an earned_at date' do
      visit(unit_membership_achievement_path(@unit, @membership, @achievement))
      expect(page).to have_current_path(unit_membership_achievement_path(@unit, @membership, @achievement))
    end

    it 'visits an achievement with an earned_at date' do
      @achievement.update!(earned_at: 2.weeks.ago)
      visit(unit_membership_achievement_path(@unit, @membership, @achievement))
      expect(page).to have_current_path(unit_membership_achievement_path(@unit, @membership, @achievement))
      expect(page).to have_text(@achievement.earned_at.to_formatted_s(:scoutaround))
    end

    it 'visits an achievement show page' do
      path = unit_membership_achievement_path(@unit.becomes(Unit), @unit.membership_for(user: @user), @achievement)
      visit path
      expect(page).to have_current_path(path)
    end

    it 'visits an achievement edit page' do
      path = edit_unit_membership_achievement_path(@unit.becomes(Unit), @unit.membership_for(user: @user), @achievement)
      visit path
      expect(page).to have_current_path(path)
    end
  end
end
