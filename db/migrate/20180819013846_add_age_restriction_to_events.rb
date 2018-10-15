class AddAgeRestrictionToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :minimum_age, :integer
  end
end
