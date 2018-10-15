after :bsa_ranks do
  rank = Rank.find_by(name: 'First Class')

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Camping and Outdoor Ethics').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Since joining Boy Scouts, participate in 10 separate troop/patrol activities, at least six of which must be held outdoors. Of the outdoor activities, at least three must include overnight camping. These activities do not include troop or patrol meetings. On campouts, spend the night in a tent that you pitch or other structure that you help erect, such as a lean-to, snow cave, or tepee.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain each of the principles of Tread Lightly! and tell how you practiced them on a campout or outing. This outing must be different from the ones used for Tenderfoot requirement 1c and Second Class requirement 1b.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Cooking').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Help plan a menu for one of the above campouts that includes at least one breakfast, one lunch, and one dinner and that requires cooking at least two of the meals. Tell how the menu includes the foods from MyPlate or the current USDA nutritional model and how it meets nutritional needs for the planned activity or campout. ').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Using the menu planned in First Class requirement 2a, make a list showing a budget and the food amounts needed to feed three or more boys. Secure the ingredients.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Show which pans, utensils, and other gear will be needed to cook and serve these meals.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate the procedures to follow in the safe handling and storage of fresh meats, dairy products, eggs, vegetables, and other perishable food products. Show how to properly dispose of camp garbage, cans, plastic containers, and other rubbish.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'On one campout, serve as cook. Supervise your assistant(s) in using a stove or building a cooking fire. Prepare the breakfast, lunch, and dinner planned in First Class requirement 2a. Supervise the cleanup.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Tools').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Discuss when you should and should not use lashings.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate tying the timber hitch and clove hitch.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate tying the square, shear, and diagonal lashings by joining two or more poles or staves together.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Use lashings to make a useful camp gadget or structure.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Navigation').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Using a map and compass, complete an orienteering course that covers at least one mile and requires measuring the height and/or width of designated items (tree, tower, canyon, ditch, etc.)').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate how to use a handheld GPS unit, GPS app on a smartphone or other electronic navigation system. Use a GPS to find your current location, a destination of your choice, and the route you will take to get there. Follow that route to arrive at your destination.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Nature').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Identify or show evidence of at least 10 kinds of native plants found in your local area or campsite location. You may show evidence by identifying fallen leaves or fallen fruit that you find in the field, or as part of a collection you have made, or by photographs you have taken.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Identify two ways to obtain a weather forecast for an upcoming activity. Explain why weather forecasts are important when planning for an event.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Describe at least three natural indicators of impending hazardous weather, the potential dangerous events that might result from such weather conditions, and the appropriate actions to take.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Describe extreme weather conditions you might encounter in the outdoors in your local geographic area. Discuss how you would determine ahead of time the potential risk of these types of weather dangers, alternative planning considerations to avoid such risks, and how you would prepare for and respond to those weather conditions.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Acquatics').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Successfully complete the BSA swimmer test.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Tell what precautions must be taken for a safe trip afloat.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Identify the basic parts of a canoe, kayak, or other boat. Identify the parts of a paddle or an oar.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Describe proper body positioning in a watercraft, depending on the type and size of the vessel. Explain the importance of proper body position in the boat.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'With a helper and a practice victim, show a line rescue both as tender and rescuer. (The practice victim should be approximately 30 feet from shore in deep water.)5').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'First Aid and Emergency Preparedness').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate bandages for a sprained ankle and for injuries on the head, the upper arm, and the collarbone.').first_or_create
  sub_req = Requirement.where(program_code: 'bsa', achievable: req, name: 'By yourself and with a partner, show how to:').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Transport a person from a smoke-filled room').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Transport for at least 25 yards a person with a sprained ankle.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Tell the five most common signals of a heart attack. Explain the steps (procedures) in cardiopulmonary resuscitation (CPR).').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Tell what utility services exist in your home or meeting place. Describe potential hazards associated with these utilities, and tell how to respond in emergency situations.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Develop an emergency action plan for your home that includes what to do in case of fire, storm, power outage, and water outage.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain how to obtain potable water in an emergency.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Fitness').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'After completing Second Class requirement 7a, be physically active at least 30 minutes every day for five days a week for four weeks. Keep track of your activities.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Share your challenges and successes in completing First Class requirement 8a. Set a goal for continuing to include physical activity as part of your daily life.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Citizenship').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Visit and discuss with a selected individual approved by your leader (for example, an elected official, judge, attorney, civil servant, principal, or teacher) the constitutional rights and obligations of a U.S. citizen.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Investigate an environmental issue affecting your community. Share what you learned about that issue with your patrol or troop. Tell what, if anything, could be done by you or your community to address the concern.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'On a Scouting or family outing, take note of the trash and garbage you produce. Before your next similar outing, decide how you can reduce, recycle, or repurpose what you take on that outing, and then put those plans into action. Compare your results.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Participate in three hours of service through one or more service projects approved by your Scoutmaster. The project(s) must not be the same service project(s) used for Tenderfoot requirement 7b and Second Class requirement 8e. Explain how your service to others relates to the Scout Law.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Leadership').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Tell someone who is eligible to join Boy Scouts, or an inactive Boy Scout, about your Scouting activities. Invite him to an outing, activity, service project or meeting. Tell him how to join, or encourage the inactive Boy Scout to become active. Share your efforts with your Scoutmaster or other adult leader.
  ').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Scout Spirit').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate scout spirit by living the Scout Oath and Scout Law. Tell how you have done your duty to God and how you have lived four different points of the Scout Law (different from those points used for previous ranks) in your everyday life. ').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'While working toward the First Class rank, and after completing Second Class requirement 11, participate in a Scoutmaster conference.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Successfully complete your board of review for the First Class rank.').first_or_create
end

print "BSA First Class requirements\n"
