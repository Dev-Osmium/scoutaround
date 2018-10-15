after :bsa_merit_badges do
  scout         = Rank.where(ordinal: 0, program_code: 'bsa', name: 'Scout').first_or_create
  tenderfoot    = Rank.where(ordinal: 1, program_code: 'bsa', name: 'Tenderfoot').first_or_create
  second_class  = Rank.where(ordinal: 2, program_code: 'bsa', name: 'Second Class').first_or_create
  first_class   = Rank.where(ordinal: 3, program_code: 'bsa', name: 'First Class').first_or_create
  star          = Rank.where(ordinal: 4, program_code: 'bsa', name: 'Star').first_or_create
  life          = Rank.where(ordinal: 5, program_code: 'bsa', name: 'Life').first_or_create
  eagle         = Rank.where(ordinal: 6, program_code: 'bsa', name: 'Eagle').first_or_create

  print "Ranks: #{Rank.count}\n"
end
