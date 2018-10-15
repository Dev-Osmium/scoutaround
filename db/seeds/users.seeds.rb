after :bsa_ranks, :bsa_unit_positions, :subscription_plans do
  def create_user(type, first_name, last_name, date_of_birth, email, rank = nil)
    user = User.create_with(
      first_name: first_name,
      last_name: last_name,
      type: type,
      date_of_birth: date_of_birth,
      rank: Rank.find_by(name: rank),
      active: true,
      password: 'goscoutaround'
    ).find_or_create_by(email: email)
  end

  owen  = create_user('Youth', 'Owen', 'McNamara', 12.years.ago,  'a1@scoutaround.org', 'Scout')
  luis  = create_user('Youth', 'Luis', 'Johnson',  13.years.ago,  'a2@scoutaround.org', 'Scout')
  jack  = create_user('Youth', 'Jack', 'Jones',    15.years.ago,  'a3@scoutaround.org', 'Star')
  aidan = create_user('Youth', 'Aidan', 'Riordan', 210.months.ago,'a4@scoutaround.org', 'Life')
  marc  = create_user('Youth', 'Marc', 'Wilson',   16.years.ago,  'a5@scoutaround.org', 'First Class')

  ray   = create_user('Adult', 'Ray', 'McNamara',  45.years.ago,  'ray@scoutaround.org')
  fred  = create_user('Adult', 'Fred', 'Marquez',  45.years.ago,  'a6@scoutaround.org')
  vince = create_user('Adult', 'Vincent', 'Jones', 55.years.ago,  'a7@scoutaround.org')
  ed    = create_user('Adult', 'Edward',  'Smith', 50.years.ago,  'a8@scoutaround.org')

  ed.update_attributes(nickname: 'Ed')

  puts "Users: #{User.count}"

  a = owen.achievements.where(achievable: Rank.find_by(name: 'Scout')).first_or_create
  a.update_attributes(earned_at: 3.months.ago)

  a = luis.achievements.where(achievable: Rank.find_by(name: 'Scout')).first_or_create
  a.update_attributes(earned_at: 2.months.ago)

  a = jack.achievements.where(achievable: Rank.find_by(name: 'Star')).first_or_create
  a.update_attributes(earned_at: 9.months.ago)

  a = marc.achievements.where(achievable: Rank.find_by(name: 'First Class')).first_or_create
  a.update_attributes(earned_at: 12.months.ago)

  a = aidan.achievements.where(achievable: Rank.find_by(name: 'Life')).first_or_create
  a.update_attributes(earned_at: 14.months.ago)

  Guardianship.find_or_create_by(
    guardian: ray,
    guardee: owen
  )

  puts "Guardianships: #{Guardianship.count}"

  troop = Troop.create_with(
    program_code:                 'bsa',
    state:                        'NY',
    chartering_organization_name: 'Immaculate Heart of Mary Church',
    council:                      'Westchester Putnam',
    district:                     'Algonquin',
    subscription_plan:            SubscriptionPlan.find_by(sku: 'annual'),
    subscription_expires_at:      1.year.from_now
  ).find_or_create_by(
    city:                         'Scarsdale',
    number:                       '2',
  )

  pack = Pack.create_with(
    program_code:                 'bsa_cubs',
    state:                        'NY',
    chartering_organization_name: 'St. Augustine\'s Church',
    council:                      'Westchester Putnam',
    district:                     'Algonqiun',
    subscription_plan:            SubscriptionPlan.find_by(sku: 'annual'),
    subscription_expires_at:      1.year.from_now    
  ).find_or_create_by(
    city:                         'Larchmont',
    number:                       '33',
  )

  User.all.each do |user|
    troop.memberships.where(user: user).first_or_create
  end

  # set up cub pack
  evan  = create_user('Youth', 'Evan', 'Hansen',   8.years.ago,   'a9@scoutaround.org')
  pack.memberships.where(user: evan).first_or_create
  pack.memberships.where(user: ray).first_or_create
  Guardianship.find_or_create_by(
    guardian: ray,
    guardee: evan
  )

  puts "Memberships: #{Membership.count}"

  # Ray is an admin & assistant scoutmaster
  p = UnitPosition.find_by(name: 'Assistant Scoutmaster')
  m = Membership.where(unit: troop, user: ray).first
  m.role = :admin
  m.unit_position = p
  m.save

  # Marc is inactive
  m = Membership.where(unit: troop, user: marc).first
  m.active = false
  m.save

  summer_camp = troop.events.create_with(
    starts_at: 8.weeks.from_now,
    ends_at: 9.weeks.from_now,
    published: true,
  ).find_or_create_by(name: '2018 Camp Itchyowie')

  troop.events.create_with(
    starts_at: 4.weeks.from_now,
    ends_at: 4.weeks.from_now,
    published: true,
  ).find_or_create_by(name: 'Whitewater Rafting')

  troop.events.create_with(
    starts_at: 56.weeks.ago,
    ends_at: 55.weeks.ago,
    published: true,
  ).find_or_create_by(name: '2017 Summer Camp')

  puts "Events: #{Event.count}"

  medical_form = summer_camp.event_requirements.where(
    type: 'DocumentEventRequirement',
    description: 'Medical Form'
  ).first_or_create

  waiver = summer_camp.event_requirements.where(
    type: 'DocumentEventRequirement',
    description: 'Waiver'
  ).first_or_create

  summer_camp.event_requirements.where(
    type: 'FeeEventRequirement',
    description: 'Camp Fee',
    amount_youth: 25000,
    amount_adult: 30000
  ).first_or_create

  owen_registration = EventRegistration.where(
    user: owen,
    event: summer_camp
  ).first_or_create

  ray_registration = EventRegistration.where(
    user: ray,
    event: summer_camp
  ).first_or_create

  EventRegistration.where(
    user: luis,
    event: summer_camp
  ).first_or_create

  EventRegistration.where(
    user: aidan,
    event: summer_camp
  ).first_or_create

  EventSubmission.where(
    event_requirement: medical_form,
    event_registration: owen_registration,
    submitter: ray,
    approver: ray,
    approved_at: Time.now
  ).first_or_create

  EventSubmission.where(
    event_requirement: waiver,
    event_registration: ray_registration,
    submitter: ray
  ).first_or_create
end
