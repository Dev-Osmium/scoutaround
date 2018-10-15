class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :user
  enum status: { attended: 0, partial: 1, self_check_in: 2 }
end
