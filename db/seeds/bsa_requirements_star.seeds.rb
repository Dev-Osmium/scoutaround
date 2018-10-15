after :bsa_ranks do
  rank = Rank.find_by(name: 'Star')

  # requirement #1: do the time
  TenureRequirement.where(program_code: 'bsa', achievable: rank, param: 4.months, precursor: Rank.find_by(name: 'First Class')).first_or_create

  # requirement #2: scout spirit, etc.
  Requirement.where(program_code: 'bsa', achievable: rank, name: 'As a First Class Scout, demonstrate Scout spirit by living the Scout Oath and Scout Law. Tell how you have done your duty to God and how you have lived the Scout Oath and Scout Law in your everyday life.').first_or_create

  # requirement #3: earn six merit badges
  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Earn six merit badges, including any four from the required list for Eagle. You may choose any of the 17 merit badges on the required list for Eagle to fulfill this requirement.')
  RequiredMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Required merit badge 1').first_or_create
  RequiredMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Required merit badge 2').first_or_create
  RequiredMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Required merit badge 3').first_or_create
  RequiredMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Required merit badge 4').first_or_create
  ElectiveMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Elective merit badge 1').first_or_create
  ElectiveMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Elective merit badge 2').first_or_create

  # service actively in your unit
  req = MultipleChoiceRequirement.where(program_code: 'bsa', achievable: rank, param: 1, name: 'While a First Class Scout, serve actively in your troop for four months in one or more of the following positions of responsibility (or carry out a Scoutmaster-approved leadership project to help the troop):').first_or_create
  # do one of the following:

  Requirement.where(program_code: 'bsa', achievable: req, name: 'Boy Scout troop. Patrol leader, assistant senior patrol leader, senior patrol leader, troop guide, Order of the Arrow troop representative, den chief, scribe, librarian, historian, quartermaster, bugler, junior assistant Scoutmaster, chaplain aide, instructor, webmaster, or outdoor ethics guide.
').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Venturing crew. President, vice president, secretary, treasurer, den chief, historian, guide, quartermaster, chaplain aide, or outdoor ethics guide.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Sea Scout ship. Boatswain, boatswain’s mate, purser, yeoman, storekeeper, crew leader, media specialist, specialist, den chief, or chaplain aide.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Lone Scout. Leadership responsibility in your school, religious organization, club, or elsewhere in your community.').first_or_create

  # cyberchip
  Requirement.where(program_code: 'bsa', achievable: rank, name: 'With your parent or guardian, complete the exercises in the pamphlet How to Protect Your Children from Child Abuse: A Parent’s Guide and earn the Cyber Chip Award for your grade').first_or_create

  # SM conference
  Requirement.where(program_code: 'bsa', achievable: rank, name: 'While a First Class Scout, participate in a Scoutmaster conference.').first_or_create

  # BOR
  Requirement.where(program_code: 'bsa', achievable: rank, name: 'Successfully complete your board of review for the Star rank.').first_or_create
end

print "BSA Star requirements\n"
