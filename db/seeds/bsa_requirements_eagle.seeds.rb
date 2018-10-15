after :bsa_ranks do
  rank = Rank.find_by(name: 'Eagle')

  #1 tenure
  TenureRequirement.where(program_code: 'bsa', achievable: rank, param: 6.months, precursor: Rank.find_by(name: 'Life')).first_or_create

  # AchievementRequirement.where(program_code: 'bsa', achievable: eagle, requirable: MeritBadge.find_by(name: 'Personal Management').becomes(Achievable)).first_or_create
  # AchievementRequirement.where(program_code: 'bsa', achievable: eagle, requirable: MeritBadge.find_by(name: 'Citizenship in the Community').becomes(Achievable)).first_or_create
  # AchievementRequirement.where(program_code: 'bsa', achievable: eagle, requirable: MeritBadge.find_by(name: 'Citizenship in the Nation').becomes(Achievable)).first_or_create
  # AchievementRequirement.where(program_code: 'bsa', achievable: eagle, requirable: MeritBadge.find_by(name: 'Citizenship in the World').becomes(Achievable)).first_or_create

  # # earn one of the following two badges:
  # green_merit_badge_option = MultipleChoiceRequirement.create(achievable: eagle, param: 1)
  # AchievementRequirement.create(program_code: 'bsa', achievable: green_merit_badge_option, requirable: MeritBadge.find_by(name: 'Sustainability').becomes(Achievable))
  # AchievementRequirement.create(program_code: 'bsa', achievable: green_merit_badge_option, requirable: MeritBadge.find_by(name: 'Environmental Science').becomes(Achievable))

  # # earn one of the following two badges:
  # preparedness_merit_badge_option = MultipleChoiceRequirement.create(achievable: eagle, param: 1)
  # AchievementRequirement.create(program_code: 'bsa', achievable: preparedness_merit_badge_option, requirable: MeritBadge.find_by(name: 'Emergency Preparedness').becomes(Achievable))
  # AchievementRequirement.create(program_code: 'bsa', achievable: preparedness_merit_badge_option, requirable: MeritBadge.find_by(name: 'Lifesaving').becomes(Achievable))

  # # earn one of the following three badges:
  # athletic_merit_badge_option = MultipleChoiceRequirement.create(achievable: eagle, param: 1)
  # AchievementRequirement.create(program_code: 'bsa', achievable: preparedness_merit_badge_option, requirable: MeritBadge.find_by(name: 'Swimming').becomes(Achievable))
  # AchievementRequirement.create(program_code: 'bsa', achievable: preparedness_merit_badge_option, requirable: MeritBadge.find_by(name: 'Cycling').becomes(Achievable))
  # AchievementRequirement.create(program_code: 'bsa', achievable: preparedness_merit_badge_option, requirable: MeritBadge.find_by(name: 'Personal Fitness').becomes(Achievable))

  # 2
  Requirement.where(program_code: 'bsa', achievable: rank, name: 'As a Life Scout, demonstrate Scout spirit by living the Scout Oath and Scout Law. Tell how you have done your duty to God and how you have lived the Scout Oath and Scout Law in your everyday life, and how your understanding of the Scout Oath and Scout Law will guide your life in the future. List on your Eagle Scout Rank Application the names of individuals who know you personally and would be willing to provide a recommendation on your behalf, including parents/guardians, religious (if not affiliated with an organized religion, then the parent or guardian provides this reference), educational, employer (if employed), and two other references.').first_or_create

  # 3 merit badges
  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Earn a total of 21 merit badges (10 more than required for the Life rank), including these 13 merit badges:')
  RequiredMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Required merit badge 1').first_or_create
  RequiredMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Required merit badge 2').first_or_create
  RequiredMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Required merit badge 3').first_or_create
  RequiredMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Required merit badge 4').first_or_create
  RequiredMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Required merit badge 5').first_or_create

  ElectiveMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Elective merit badge 1').first_or_create
  ElectiveMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Elective merit badge 2').first_or_create
  ElectiveMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Elective merit badge 3').first_or_create
  ElectiveMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Elective merit badge 4').first_or_create
  ElectiveMeritBadgeRequirement.where(program_code: 'bsa', achievable: req, name: 'Elective merit badge 5').first_or_create

  # requirement #4 service actively in your unit
  req = MultipleChoiceRequirement.where(program_code: 'bsa', achievable: rank, param: 1, name: 'While a First Class Scout, serve actively in your troop for four months in one or more of the following positions of responsibility (or carry out a Scoutmaster-approved leadership project to help the troop):').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Boy Scout troop. Patrol leader, assistant senior patrol leader, senior patrol leader, troop guide, Order of the Arrow troop representative, den chief, scribe, librarian, historian, quartermaster, bugler, junior assistant Scoutmaster, chaplain aide, instructor, webmaster, or outdoor ethics guide.
').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Venturing crew. President, vice president, secretary, treasurer, den chief, historian, guide, quartermaster, chaplain aide, or outdoor ethics guide.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Sea Scout ship. Boatswain, boatswain’s mate, purser, yeoman, storekeeper, crew leader, media specialist, specialist, den chief, or chaplain aide.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Lone Scout. Leadership responsibility in your school, religious organization, club, or elsewhere in your community.').first_or_create

  # 5 eagle project
  Requirement.where(program_code: 'bsa', achievable: rank, name: 'While a Life Scout, plan, develop, and give leadership to others in a service project helpful to any religious institution, any school, or your community. (The project must benefit an organization other than Boy Scouting.) A project proposal must be approved by the organization benefiting from the effort, your unit leader and unit committee, and the council or district before you start. You must use the Eagle Scout Service Project Workbook, BSA publication No. 512-927, in meeting this requirement. (To learn more about the Eagle Scout service project, see the Guide to Advancement, topics 9.0.2.0 through 9.0.2.16.)').first_or_create

  # 6
  Requirement.where(program_code: 'bsa', achievable: rank, name: 'While a Life Scout, participate in a Scoutmaster[2] conference.').first_or_create

  # 7
  Requirement.where(program_code: 'bsa', achievable: rank, name: 'Successfully complete your board of review for the Eagle rank.[4] In preparation for your board of review, prepare and attach to your Eagle Scout Rank Application a statement of your ambitions and life purpose and a listing of positions held in your religious institution, school, camp, community, or other organizations, during which you demonstrated leadership skills. Include honors and awards received during this service. (This requirement may be met after age 18, in accordance with Guide to Advancement topic 8.0.3').first_or_create
end

print "BSA Eagle requirements\n"
