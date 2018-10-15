class Rank < Achievable
  def next_rank
    Rank.find_by(ordinal: self.ordinal + 1, program_code: self.program_code)
  end
end
