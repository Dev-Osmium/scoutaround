after :bsa_ranks do
  rank = Rank.find_by(name: 'Second Class')

  # Camping and Outdoor Ethics
  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Camping and Outdoor Ethics').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Since joining Boy Scouts, participate in five separate troop/patrol activities, at least three of which must be held outdoors. Of the outdoor activities, at least two must include overnight camping. These activities do not include troop or patrol meetings. On campouts, spend the night in a tent that you pitch or other structure that you help erect, such as a lean-to, snow cave, or tepee.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain the seven principles of Leave No Trace and tell how you practiced them on a campout or outing. This outing must be different from the one used for "Tenderfoot requirement 1c".').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'On one of these campouts, select a location for your patrol site and recommend it to your patrol leader, senior patrol leader, or troop guide. Explain what factors you should consider when choosing a patrol site and where to pitch a tent. ').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Cooking and Tools').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain when it is appropriate to use a fire for cooking or other purposes and when it would not be appropriate to do so.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Use the tools listed in Tenderfoot requirement 3d to prepare tinder, kindling, and fuel wood for a cooking fire.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'At an approved outdoor location and time, use the tinder, kindling, and fuel wood from "Second Class requirement 2b" to demonstrate how to build a fire. Unless prohibited by local fire restrictions, light the fire. After allowing the flames to burn safely for at least two minutes, safely extinguish the flames with minimal impact to the fire site.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain when it is appropriate to use a lightweight stove and when it is appropriate to use a propane stove. Set up a lightweight stove or propane stove. Light the stove, unless prohibited by local fire restrictions. Describe the safety procedures for using these types of stoves. ').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'On one campout, plan and cook one hot breakfast or lunch, selecting foods from MyPlate or the current USDA nutritional model. Explain the importance of good nutrition. Demonstrate how to transport, store, and prepare the foods you selected.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate tying the sheet bend knot. Describe a situation in which you would use this knot.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate tying the bowline knot. Describe a situation in which you would use this knot.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Navigation').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate how a compass works and how to orient a map. Use a map to point out and tell the meaning of five map symbols.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Using a compass and map together, take a 5-mile hike (or 10 miles by bike) approved by your adult leader and your parent or guardian.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Describe some hazards or injuries that you might encounter on your hike and what you can do to help prevent them.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate how to find directions during the day and at night without using a compass or an electronic device.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Nature').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Identify or show evidence of at least 10 kinds of wild animals (such as birds, mammals, reptiles, fish, or mollusks) found in your local area or camping location. You may show evidence by tracks, signs, or photographs you have taken.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Aquatics').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Tell what precautions must be taken for a safe swim.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate your ability to pass the BSA beginner test: Jump feetfirst into water over your head in depth, level off and swim 25 feet on the surface, stop, turn sharply, resume swimming, then return to your starting place.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate water rescue methods by reaching with your arm or leg, by reaching with a suitable object, and by throwing lines and objects.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain why swimming rescues should not be attempted when a reaching or throwing rescue is possible. Explain why and how a rescue swimmer should avoid contact with the victim.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'First Aid and Emergency Preparedness').first_or_create
  sub_req = Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate first aid for the following:').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Object in the eye').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Bite of a warm-blooded animal').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Puncture wounds from a splinter, nail, and fishhook').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Serious burns (partial thickness, or second-degree)').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Heat exhaustion').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Shock').first_or_create
    Requirement.where(program_code: 'bsa', achievable: sub_req, name: 'Heatstroke, dehydration, hypothermia, and hyperventilation').first_or_create

  Requirement.where(program_code: 'bsa', achievable: req, name: 'Show what to do for “hurry” cases of stopped breathing, stroke, severe bleeding, and ingested poisoning.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Tell what you can do while on a campout or hike to prevent or reduce the occurrence of the injuries listed in Second Class requirements 6a and 6b.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain what to do in case of accidents that require emergency response in the home and backcountry. Explain what constitutes an emergency and what information you will need to provide to a responder.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Tell how you should respond if you come upon the scene of a vehicular accident.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Fitness').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'After completing Tenderfoot requirement 6c, be physically active at least 30 minutes each day for five days a week for four weeks. Keep track of your activities.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Share your challenges and successes in completing Second Class requirement 7a. Set a goal for continuing to include physical activity as part of your daily life and develop a plan for doing so.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Participate in a school, community, or troop program on the dangers of using drugs, alcohol, and tobacco and other practices that could be harmful to your health. Discuss your participation in the program with your family, and explain the dangers of substance addictions. Report to your Scoutmaster or other adult leader in your troop about which parts of the Scout Oath and Scout Law relate to what you learned.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Citizenship').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Participate in a flag ceremony for your school, religious institution, chartered organization, community, or Scouting activity.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain what respect is due the flag of the United States.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'With your parents or guardian, decide on an amount of money that you would like to earn, based on the cost of a specific item you would like to purchase. Develop a written plan to earn the amount agreed upon and follow that plan; it is acceptable to make changes to your plan along the way. Discuss any changes made to your original plan and whether you met your goal.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'At a minimum of three locations, compare the cost of the item for which you are saving to determine the best place to purchase it. After completing Second Class requirement 8c, decide if you will use the amount that you earned as originally intended, save all or part of it, or use it for another purpose.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Participate in two hours of service through one or more service projects approved by your Scoutmaster. Explain how your service to others relates to the Scout Oath.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Personal Safety Awareness').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Explain the three R’s of personal safety and protection.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Describe bullying; tell what the appropriate response is to someone who is bullying you or another person.').first_or_create

  req = Requirement.where(program_code: 'bsa', achievable: rank, name: 'Scout Spirit').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Demonstrate Scout spirit by living the Scout Oath and Scout Law. Tell how you have done your duty to God and how you have lived four different points of the Scout Law (not to include those used for Tenderfoot requirement 9) in your everyday life.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'While working toward the Second Class rank, and after completing Tenderfoot requirement 10, participate in a Scoutmaster conference.').first_or_create
  Requirement.where(program_code: 'bsa', achievable: req, name: 'Successfully complete your board of review for the Second Class rank.').first_or_create
end

print "BSA Second Class requirements\n"
