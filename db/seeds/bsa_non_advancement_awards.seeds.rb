NonAdvancementAward.where(program_code: 'bsa', name: 'Mile Swim').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: '50 Miler').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Kayaking BSA Award').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Boardsailing BSA Award').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Cyber Chip Award').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Totin\' Chip').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Firem\'n Chip').first_or_create

# religious awards see https://www.scouting.org/awards/religious-awards/chart/
NonAdvancementAward.where(program_code: 'bsa', name: 'God and Church').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'God and Life').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'God and Country').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Ararat').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Unity of Mankind').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Sangha').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Light Is Life').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Pope Pius XII').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Ad Altare Dei').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'On My Honor').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Good Servant').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Path of the Disciple').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Alpha Omega').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Open Word Award').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Dharma').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Karma').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'In the Name of God').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Ner Tamid').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Etz Chaim').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Compassionate Father').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Spirit of Truth').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Gyan Kharg').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Religion in Life').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Light of God').first_or_create
NonAdvancementAward.where(program_code: 'bsa', name: 'Good Life').first_or_create

print "BSA non-advancement awards: #{NonAdvancementAward.count}\n"
