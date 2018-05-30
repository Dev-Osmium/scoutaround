def create_user(type, first_name, last_name, email, rank = nil)
  User.create_with(
    first_name: first_name,
    last_name: last_name,
    type: type,
    rank: rank,
    active: true,
    password: 'goscoutaround'
  ).find_or_create_by(email: email)
end

owen  = create_user('Youth', 'Owen', 'McNamara', 'a1@scoutaround.org', 'Scout')
luis  = create_user('Youth', 'Luis', 'Johnson', 'a2@scoutaround.org', 'Scout')
jack  = create_user('Youth', 'Jack', 'Jones', 'a3@scoutaround.org', 'Star')
aidan = create_user('Youth', 'Aidan', 'Riordan', 'a4@scoutaround.org', 'Life')
marc  = create_user('Youth', 'Marc', 'Wilson', 'a5@scoutaround.org', 'First Class')

ray   = create_user('Adult', 'Ray', 'McNamara', 'ray@scoutaround.org')
fred  = create_user('Adult', 'Fred', 'Marquez', 'a6@scoutaround.org')
vince = create_user('Adult', 'Vincent', 'Jones', 'a7@scoutaround.org')
ed    = create_user('Adult', 'Edward',  'Smith', 'a8@scoutaround.org')

puts "Users: #{User.count}"

Guardianship.find_or_create_by(
  guardian: ray,
  guardee: owen
)

puts "Guardianships: #{Guardianship.count}"

troop = Troop.where(number: '28', location: 'Santa Ana, CA').first_or_create

User.all.each do |user|
  troop.memberships.where(user: user).first_or_create
end

puts "Memberships: #{Membership.count}"

# Ray is an admin
m = Membership.where(unit: troop, user: ray).first
m.role = :admin
m.save

m = Membership.where(unit: troop, user: marc).first
m.active = false
m.save

summer_camp = troop.events.create_with(
  starts_at: 8.weeks.from_now,
  ends_at: 9.weeks.from_now
).find_or_create_by(name: '2018 Camp Itchyowie')

troop.events.create_with(
  starts_at: 4.weeks.from_now,
  ends_at: 4.weeks.from_now
).find_or_create_by(name: 'Whitewater Rafting')

troop.events.create_with(
  starts_at: 56.weeks.ago,
  ends_at: 55.weeks.ago
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
  type: 'PaymentEventRequirement',
  description: 'Camp Fee',
  amount: 250
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