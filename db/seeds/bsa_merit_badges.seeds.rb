print "BSA Merit Badges: "

merit_badge_names = [
  'Personal Management', 'Swimming', 'Emergency Preparedness', 'Personal Fitness', 'First Aid',
  'Citizenship in the Community', 'Citizenship in the Nation', 'Citizenship in the World',
  'Lifesaving', 'Camping', 'Communication', 'Cooking', 'Cycling', 'Environmental Science',
  'Family Life', 'Hiking', 'Sustainability',
  'American Business', 'American Cultures', 'American Heritage', 'American Labor', 'Animal Science',
  'Animation', 'Archaeology', 'Archery', 'Architecture', 'Art', 'Astronomy', 'Athletics', 'Automotive Maintenance',
  'Aviation', 'Backpacking', 'Basketry', 'Bird Study', 'Bugling', 'Canoeing', 'Chemistry', 'Chess',
  'Climbing', 'Coin Collecting', 'Collections', 'Composite Materials', 'Crime Prevention', 'Dentistry',
  'Digital Technology', 'Disabilities Awareness', 'Dog Care', 'Drafting', 'Electricity', 'Electronics',
  'Energy', 'Engineering', 'Entrepreneurship', 'Exploration', 'Farm Mechanics', 'Fingerprinting',
  'Fire Safety', 'Fish and Wildlife Management', 'Fishing', 'Fly Fishing', 'Forestry', 'Game Design', 'Gardening',
  'Geneology', 'Geocaching', 'Geology', 'Golf', 'Graphic Arts', 'Home Repairs', 'Horsemanship', 'Indian Lore',
  'Insect Study', 'Inventing', 'Journalism', 'Kayaking', 'Landscape Architecture', 'Law', 'Leatherworking',
  'Mammal Study', 'Medicine', 'Metalwork', 'Mining in Society', 'Model Design and Building', 'Motorboating',
  'Moviemaking', 'Music', 'Nature', 'Nuclear Science', 'Oceanography', 'Orienteering', 'Painting', 'Pets', 'Photography',
  'Pioneering', 'Plant Science', 'Plumbing', 'Pottery', 'Programming', 'Public Health', 'Public Speaking',
  'Pulp and Paper', 'Radio', 'Railroading', 'Reading', 'Reptile and Amphibian Study', 'Rifle Shooting', 'Robotics',
  'Rowing', 'Safety', 'Salesmanship', 'Scholarship', 'Scouting Heritage', 'Scuba Diving', 'Sculpture', 'Search & Rescue',
  'Shotgun Shooting', 'Signals, Signs, and Codes', 'Skating', 'Small-Boat Sailing', 'Snow Sports',
  'Soil and Water Conservation', 'Space Exploration', 'Sports', 'Stamp Collecting', 'Surveying', 'Textile', 'Theater',
  'Traffic Safety', 'Truck Transportation', 'Veterinary Medicine', 'Water Sports', 'Weather', 'Welding', 'Whitewater',
  'Wilderness Survival', 'Wood Carving', 'Woodwork'
]

merit_badge_names.each do |name|
  MeritBadge.where(program_code: 'bsa', name: name).first_or_create
end

print "#{MeritBadge.count}\n"
