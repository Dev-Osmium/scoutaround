after :bsa_ranks do
  tenderfoot = Rank.find_by(name: 'Tenderfoot')

  # Camping and Outdoor Ethics
  req = Requirement.where(program_code: 'bsa', achievable: tenderfoot, name: 'Camping and Outdoor Ethics').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Present yourself to your leader prepared for an overnight camping trip. Show the personal and camping gear you will use. Show the right way to pack and carry it.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Spend at least one night on a patrol or troop campout. Sleep in a tent you have helped pitch.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Tell how you practiced the Outdoor Code on a campout or outing.').first_or_create

  # Cooking
  req = Requirement.where(program_code: 'bsa', achievable: tenderfoot, name: 'Camping and Outdoor Ethics').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'On the campout, assist in preparing one of the meals. Tell why it is important for each patrol member to share in meal preparation and cleanup.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'While on a campout, demonstrate the appropriate method of safely cleaning items used to prepare, serve, and eat a meal.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain the importance of eating together as a patrol.').first_or_create

  # Tools
  req = Requirement.where(program_code: 'bsa', achievable: tenderfoot, name: 'Tools').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate a practical use of the square knot.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate a practical use of two half-hitches.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate a practical use of the taut line hitch.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate proper care, sharpening, and use of the knife, saw, and ax. Describe when each should be used.').first_or_create

  # First Aid and Nature
  req = Requirement.where(program_code: 'bsa', achievable: tenderfoot, name: 'First Aid and Nature').first_or_create
  sub_req = Requirement.where(program_code: 'bsa', achievable: req, name: 'Show first aid for the following:').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Simple cuts and scrapes').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Blisters on the hand and foot').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Minor (thermal/heat) burns or scalds (superficial, or first degree)').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Bites or stings of insects or ticks').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Venomous snakebite').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Nosebleed').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Frostbite and sunburn').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Choking').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Describe common poisonous or hazardous plants, identify any that grow in your local area or campsite location. Tell how to treat for exposure to them.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Tell what you can do on a campout or other outdoor activity to prevent or reduce the occurrence of injuries or exposure listed in Tenderfoot requirements 4a and 4b.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Assemble a personal first-aid kit to carry with you on future campouts and hikes. Tell how each item in the kit would be used.').first_or_create

  # Hiking
  req = Requirement.where(program_code: 'bsa', achievable: tenderfoot, name: 'Hiking').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain the importance of the buddy system as it relates to your personal safety on outings and in your neighborhood. Use the buddy system while on a troop or patrol outing.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain what to do if you become lost on a hike or campout.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain the rules of safe hiking, both on the highway and cross-country, during the day and at night.').first_or_create

  # Fitness
  req = Requirement.where(program_code: 'bsa', achievable: tenderfoot, name: 'Fitness').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Record your best in the following tests:').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Develop and describe a plan for improvement in each of the activities listed in Tenderfoot requirement 6a. Keep track of your activity for at least 30 days.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Show improvement (of any degree) in each activity listed in Tenderfoot requirement 6a after practicing for 30 days.
  ').first_or_create

  # Citizenship
  req = Requirement.where(program_code: 'bsa', achievable: tenderfoot, name: 'Citizenship').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate how to display, raise, lower, and fold the U.S. flag.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Participate in a total of one hour of service in one or more service projects approved by your Scoutmaster. Explain how your service to others relates to the Scout slogan and Scout motto.').first_or_create

  # Leadership
  req = Requirement.where(program_code: 'bsa', achievable: tenderfoot, name: 'Leadership').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Describe the steps in Scouting\'s Teaching EDGE method. Use the Teaching EDGE method to teach another person how to tie the square knot.
  ').first_or_create

  # Scout Spirit
  req = Requirement.where(program_code: 'bsa', achievable: tenderfoot, name: 'Scout Spirit').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate Scout spirit by living the Scout Oath and Scout Law. Tell how you have done your duty to God and how you have lived four different points of the Scout Law in your everyday life.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'While working toward Tenderfoot rank, and after completing Scout rank requirement 7, participate in a Scoutmaster conference.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Successfully complete your board of review for the Tenderfoot rank.').first_or_create
end

print "BSA Tenderfoot requirements\n"
