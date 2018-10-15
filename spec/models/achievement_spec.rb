require 'rails_helper'

RSpec.describe Achievement, type: :model do
  it 'prevents achievements on virtual requirements' do
    rank        = Rank.create(description: 'I am a rank')
    parent_req  = Requirement.create!(description: 'I have children', achievable: rank)
    child_req   = Requirement.create!(description: 'I am a child', achievable: parent_req)
    user        = FactoryBot.create(:user)

    # these really belong in an achievable_spec, but here they are
    expect(parent_req.concrete?).to be_falsey
    expect(child_req.concrete?).to be_truthy

    abstract_achievement = Achievement.new(achievable: parent_req, user: user)
    expect(abstract_achievement).not_to be_valid

    concrete_achievement = Achievement.new(achievable: child_req, user: user)
    expect(concrete_achievement).to be_valid
  end

  describe 'scopes' do
    before do
      @unit       = FactoryBot.create(:troop)
      @scout      = FactoryBot.create(:rank, :scout)
      @tenderfoot = FactoryBot.create(:rank, :tenderfoot)

      @timmy = FactoryBot.create(:youth, first_name: 'Timothy', nickname: 'Timmy')
      @tommy = FactoryBot.create(:youth, first_name: 'Thomas', nickname: 'Tommy')
      @jimmy = FactoryBot.create(:youth, first_name: 'James', nickname: 'Jimmy')

      @unit.memberships.create(user: @timmy)
      @unit.memberships.create(user: @tommy)
      @unit.memberships.create(user: @jimmy, active: false)

      @awarded    = @timmy.achievements.create(achievable: @tenderfoot, earned_at: 2.weeks.ago, awarded_at: 2.days.ago)
      @unawarded  = @tommy.achievements.create(achievable: @scout, earned_at: 2.weeks.ago, awarded_at: nil) # earned, but unawarded
      @inactive   = @jimmy.achievements.create(achievable: @scout, earned_at: 2.weeks.ago, awarded_at: nil) # earned, unawarded, inactive member
      @unapproved = @tommy.achievements.create(achievable: @tenderfoot, earned_at: nil)
    end

    it 'merit badges' do
    end

    it 'ranks' do
    end

    it 'non-advancement awards' do
    end

    it 'awardable' do
    end

    it 'earned' do
      expect(@unit.achievements.earned).to include(@unawarded)
      expect(@unit.achievements.earned).not_to include(@unapproved)
    end

    it 'unapproved' do
      expect(@unit.achievements.unapproved).to include(@unapproved)
      expect(@unit.achievements.unapproved).not_to include(@awarded)
    end

    it 'unawarded' do
      expect(@unit.achievements.unawarded).to include(@unawarded)
      expect(@unit.achievements.unawarded).not_to include(@awarded)
      expect(@unit.achievements.unawarded).not_to include(@inactive)
    end
  end

  it 'has a next rank' do
    scout = Rank.where(ordinal: 0, name: 'Scout', program_code: 'bsa').first_or_create
    snork = Rank.where(ordinal: 1, name: 'Snork', program_code: 'snork_scouts_of_america').first_or_create
    tenderfoot = Rank.where(ordinal: 1, name: 'Tenderfoot', program_code: 'bsa').first_or_create

    expect(scout.next_rank).to eq(tenderfoot)
  end
end
