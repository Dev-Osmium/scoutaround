after :bsa_ranks do
  rank = Rank.find_by(name: 'Life')
  TenureRequirement.where(program_code: 'bsa', achievable: rank, param: 6.months, precursor: Rank.find_by(name: 'Star')).first_or_create

  # requirement #2: scout spirit, etc.
  Requirement.where(program_code: 'bsa', achievable: rank, name: 'As a Star Class Scout, demonstrate Scout spirit by living the Scout Oath and Scout Law. Tell how you have done your duty to God and how you have lived the Scout Oath and Scout Law in your everyday life.').first_or_create

  # requirement #3: earn six merit badges
  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Earn five merit badges, including any four from the required list for Eagle. You may choose any of the 17 merit badges on the required list for Eagle to fulfill this requirement.')
  RequiredMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Required merit badge 1').first_or_create
  RequiredMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Required merit badge 2').first_or_create
  RequiredMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Required merit badge 3').first_or_create
  ElectiveMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Elective merit badge 1').first_or_create
  ElectiveMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Elective merit badge 2').first_or_create

  # requirement #4 service projects
  Requirement.where(program_code: 'bsa', achievable: rank, name: 'While a Star Scout, participate in six hours of service through one or more service projects approved by your Scoutmaster[1]. At least three hours of this service must be conservation-related.').first_or_create

  # requirement #5 service actively in your unit
  req = MultipleChoiceRequirement.where(program_code: 'bsa', achievable: rank, param: 1, name: 'While a First Class Scout, serve actively in your troop for four months in one or more of the following positions of responsibility (or carry out a Scoutmaster-approved leadership project to help the troop):').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Boy Scout troop. Patrol leader, assistant senior patrol leader, senior patrol leader, troop guide, Order of the Arrow troop representative, den chief, scribe, librarian, historian, quartermaster, bugler, junior assistant Scoutmaster, chaplain aide, instructor, webmaster, or outdoor ethics guide.
').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Venturing crew. President, vice president, secretary, treasurer, den chief, historian, guide, quartermaster, chaplain aide, or outdoor ethics guide.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Sea Scout ship. Boatswain, boatswain’s mate, purser, yeoman, storekeeper, crew leader, media specialist, specialist, den chief, or chaplain aide.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Lone Scout. Leadership responsibility in your school, religious organization, club, or elsewhere in your community.').first_or_create

  # requirement #6 EDGE method
  req = MultipleChoiceRequirement.where(program_code: 'bsa', achievable: rank, param: 1, name: 'While a Star Scout, use the Teaching EDGE method to teach another Scout (preferably younger than you) the skills from ONE of the following choices, so that he is prepared to pass those requirements to his Scoutmaster’s[1] satisfaction.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Tenderfoot 4a and 4b (first aid)').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Second Class 2b, 2c, and 2d (cooking/tools)').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Second Class 3a and 3d (navigation)').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'First Class 3a, 3b, 3c, and 3d (tools)').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'First Class 4a and 4b (navigation)').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Second Class 6a and 6b (first aid)').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'First Class 7a and 7b (first aid)').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Three requirements from one of the required Eagle merit badges, as approved by your Scoutmaster').first_or_create

  # 7 SM conference
  Requirement.where(program_code: 'bsa', achievable: rank, name: 'While a First Class Scout, participate in a Scoutmaster conference.').first_or_create

  # 8 BOR
  Requirement.where(program_code: 'bsa', achievable: rank, name: 'Successfully complete your board of review for the Star rank.').first_or_create
end

print "BSA Life requirements\n"
