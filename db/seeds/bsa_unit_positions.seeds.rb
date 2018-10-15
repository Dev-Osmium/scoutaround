PrototypePosition.destroy_all

PrototypePosition.where(program_code: 'bsa', audience: 'adult', name: 'Committee Chair').first_or_create
PrototypePosition.where(program_code: 'bsa', audience: 'adult', name: 'Scoutmaster').first_or_create
PrototypePosition.where(program_code: 'bsa', audience: 'adult', exclusive: false, name: 'Assistant Scoutmaster').first_or_create
PrototypePosition.where(program_code: 'bsa', audience: 'adult', exclusive: false, name: 'Committee Member').first_or_create

PrototypePosition.where(program_code: 'bsa', audience: 'youth', name: 'Senior Patrol Leader').first_or_create
PrototypePosition.where(program_code: 'bsa', audience: 'youth', name: 'Assistant Senior Patrol Leader').first_or_create
PrototypePosition.where(program_code: 'bsa', audience: 'youth', name: 'Quartermaster').first_or_create
PrototypePosition.where(program_code: 'bsa', audience: 'youth', name: 'Bugler').first_or_create
PrototypePosition.where(program_code: 'bsa', audience: 'youth', name: 'Scribe').first_or_create
PrototypePosition.where(program_code: 'bsa', audience: 'youth', name: 'Chaplain\'s Aid').first_or_create
PrototypePosition.where(program_code: 'bsa', audience: 'youth', exclusive: false, name: 'Patrol Leader').first_or_create
PrototypePosition.where(program_code: 'bsa', audience: 'youth', exclusive: false, name: 'Assistant Patrol Leader').first_or_create
PrototypePosition.where(program_code: 'bsa', audience: 'youth', exclusive: false, name: 'Junior Assistant Scoutmaster').first_or_create

PrototypePosition.where(program_code: 'cubs', audience: 'adult', name: 'Committee Chair').first_or_create
PrototypePosition.where(program_code: 'cubs', audience: 'adult', name: 'Cubmaster').first_or_create
PrototypePosition.where(program_code: 'cubs', audience: 'adult', exclusive: false, name: 'Assistant Cubmaster').first_or_create
PrototypePosition.where(program_code: 'cubs', audience: 'adult', exclusive: false, name: 'Den Leader').first_or_create
PrototypePosition.where(program_code: 'cubs', audience: 'adult', exclusive: false, name: 'Committee Member').first_or_create

UnitPosition.where(name: 'Committe Member').update_all(name: 'Committee Member', exclusive: false)
